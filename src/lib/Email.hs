{-# LANGUAGE OverloadedStrings #-}

module Email where

import Colog.Core (LogAction (..), logStringStdout, (<&))
import Control.Monad.Except (runExceptT)
import Data (EmailConfig (eDestination, eEmail, eHost, eName, ePassword))
import Data.Aeson (FromJSON, decode, withObject, (.:))
import Data.Aeson.Types (FromJSON (parseJSON))
import qualified Data.ByteString as B
import Data.ByteString.Char8 as C8
import qualified Data.ByteString.Lazy as L
import Data.ByteString.Lazy.UTF8 as BLU (fromString)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text as Text
import Network.HTTP.Client (responseTimeoutMicro)
import Network.HTTP.Simple (
    getResponseBody,
    httpBS,
    parseRequest,
    setRequestResponseTimeout,
 )
import Network.Mail.Mime (
    Address (Address),
    Part,
    filePartBS,
    htmlPart,
    plainPart,
 )
import Network.Mail.SMTP (
    Address (Address),
    sendMailWithLogin,
    sendMailWithLoginTLS,
    simpleMail,
 )

cc :: [a]
cc = []
bcc :: [a]
bcc = []
subject :: Text
subject = "Daily Magazine Updation Pushing"

sendEmailOut :: EmailConfig -> Text -> IO ()
sendEmailOut conf url = do
    let logger = logStringStdout
    let password = Text.unpack $ ePassword conf
    let user = eEmail conf
    let host = Text.unpack $ eHost conf
    let from = Address (Just $ eName conf) user

    let to = [Address (Just "kindle") $ eDestination conf]
    attachment <- networkFilePart url
    logger <& "retrieve attechment successfully"
    let mail = simpleMail from to cc bcc subject [attachment]
    logger <& "prepare to send out the mail"
    sendMailWithLoginTLS host (Text.unpack user) password mail
    logger <& "sent email successfully"

networkFilePart :: Text -> IO Part
networkFilePart url = do
    let fileName = Prelude.last $ T.splitOn "/" url
    req <- parseRequest $ T.unpack url
    let timeout = responseTimeoutMicro 60000000
    let req' = setRequestResponseTimeout timeout req
    resp <- httpBS req
    let content = getResponseBody resp
    return $ filePartBS "application/octet-stream" fileName $ L.pack $ B.unpack content
