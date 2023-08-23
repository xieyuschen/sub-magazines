{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Auth (getEmailConfig, getGithubKey)
import Colog.Core (LogAction (..), logStringStdout, (<&))
import Control.Applicative (Applicative (liftA2))
import Control.Monad (join)
import Control.Monad.Cont (forM_)
import Control.Monad.Trans.Except (runExceptT)
import Data (Author (date), Commit (author), CommitDetail (commit, files), EmailConfig, File (raw_url, status))
import Data.Aeson (decode)
import Data.ByteString.Lazy.UTF8 as BLU (fromString)
import qualified Data.Text as Text
import Data.Time (getCurrentTime)
import Email (sendEmailOut)
import GHC.Stack (getCurrentCCS)
import Github (sendRequest, withinOneDay)

main :: IO ()
main = app

app :: IO ()
app = do
    let logger = logStringStdout
    keyEx <- runExceptT getGithubKey
    let Right key = keyEx
    rawConfEx <- runExceptT getEmailConfig

    let Right rawConf = rawConfEx

    result <- sendRequest "hehonghui/awesome-english-ebooks" key

    case result of
        Nothing -> logger <& "fail to get response data"
        Just info -> do
            now <- getCurrentTime
            if withinOneDay now $ date $ author $ commit info
                then do
                    case decode $ BLU.fromString rawConf of
                        Nothing -> logger <& "fail to analyze json to Email Config"
                        Just emailConf -> do
                            let filters = liftA2 (&&) (\x -> status x == Text.pack "added") (\x -> Text.isSuffixOf (raw_url x) $ Text.pack ".epub")
                            let addedUrl = map raw_url $ filter filters (files info)
                            forM_ addedUrl (sendEmailOut emailConf)
                else logger <& "no recently(1 day) updated books"