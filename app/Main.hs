{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

-- option+shift+f to format
import Auth (getGithubKey)
import Control.Monad.Trans.Except (runExceptT)
import Data (Author (date), Commit (author), CommitDetail (commit))
import Data.Time (getCurrentTime)
import GHC.Stack (getCurrentCCS)
import Github (sendRequest, withinOneDay)

main :: IO ()
main = app

app :: IO ()
app = do
    keyEx <- runExceptT getGithubKey
    let Right key = keyEx
    putStrLn key
    result <- sendRequest "hehonghui/awesome-english-ebooks" key
    case result of
        Nothing -> print "fail to get response data"
        Just info -> do
            now <- getCurrentTime
            if withinOneDay now $ date $ author $ commit info
                then print info
                else print "no recently(1 day) updated books"