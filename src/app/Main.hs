{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Auth (getEmailConfig, getGithubKey)
import Control.Applicative (Applicative (liftA2))
import Control.Monad (join)
import Control.Monad.Cont (MonadTrans (lift), forM_)
import Control.Monad.Trans.Except (runExceptT)
import Data (Author (date), Commit (author), CommitDetail (commit, files), EmailConfig, File (raw_url, status))
import Data.Aeson (decode)
import Data.ByteString.Lazy.UTF8 as BLU (fromString)
import qualified Data.Text as Text
import Data.Time (defaultTimeLocale, formatTime, getCurrentTime)
import Email (sendEmailOut)
import GHC.Stack (getCurrentCCS)
import Github (sendRequest)
import Util (getAddedEpubLinks, withinOneDay)

import Colog (
    HasLog (..),
    LogAction,
    Message,
    SimpleMsg,
    WithLog,
    cmap,
    fmtMessage,
    fmtSimpleMessage,
    formatWith,
    log,
    logDebug,
    logError,
    logInfo,
    logStringStdout,
    logText,
    logTextStderr,
    logTextStdout,
    richMessageAction,
    usingLoggerT,
    (<&),
    pattern D,
    pattern E,
    pattern I,
 )
import Control.Monad.Reader (ReaderT (ReaderT, runReaderT))
import GHC.Base (IO (IO))
import Prelude hiding (log)

main :: IO ()
main = app


logStdoutAction :: LogAction IO Message
logStdoutAction = cmap fmtMessage logTextStdout

runLog s str = usingLoggerT logStdoutAction $ log s str

app :: IO ()
app = do
    runLog I "start cronjob of sub-magazine"
    runLog I "read credentials from environment"
    keyEx <- runExceptT getGithubKey
    let Right key = keyEx
    rawConfEx <- runExceptT getEmailConfig

    let Right rawConf = rawConfEx
    runLog I "prepare to get newest commit of repo hehonghui/awesome-english-ebook from github"
    result <- sendRequest "hehonghui/awesome-english-ebooks" key
    case result of
        Nothing -> runLog E "fail to get response data"
        Just info -> do
            runLog I "get response from github successfully"
            now <- getCurrentTime
            runLog I $ Text.pack ("current time is: " ++ formatTime defaultTimeLocale "%m/%d/%Y %I:%M %p" now)
            let lastUpdate = date $ author $ commit info
            runLog I $ Text.pack ("last time date is: " ++ formatTime defaultTimeLocale "%m/%d/%Y %I:%M %p" lastUpdate)
            if withinOneDay now lastUpdate
                then do
                    runLog I "last updating is within one day"
                    case decode $ BLU.fromString rawConf of
                        Nothing -> runLog E "fail to analyze json to email config"
                        Just emailConf -> do
                            let links = getAddedEpubLinks info
                            runLog D $ Text.unlines links
                            forM_ links (sendEmailOut emailConf)
                else runLog I "no recently(1 day) updated books"