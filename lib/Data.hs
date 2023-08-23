{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Data where

import Data.Aeson (
    FromJSON (parseJSON),
    withObject,
    (.:),
    (.:?),
 )
import Data.Text (Text)
import Data.Time (UTCTime)

data CommitDetail = CommitDetail
    { sha :: Text
    , commit :: Commit
    , files :: [File]
    }
    deriving (Show)

instance FromJSON CommitDetail where
    parseJSON = withObject "CommitDetail" $ \o ->
        CommitDetail
            <$> o
            .: "sha"
            <*> o
            .: "commit"
            <*> o
            .: "files"

newtype Commit = Commit
    { author :: Author
    }
    deriving (Show)

instance FromJSON Commit where
    parseJSON = withObject "Commit" $ \o ->
        Commit
            <$> o
            .: "author"

data Author = Author
    { name :: Text
    , date :: UTCTime
    }
    deriving (Show)

instance FromJSON Author where
    parseJSON = withObject "Author" $ \o ->
        Author
            <$> o
            .: "name"
            <*> o
            .: "date"

data File = File
    { filename :: Text
    , status :: Text
    , raw_url :: Text
    }
    deriving (Show)

instance FromJSON File where
    parseJSON = withObject "File" $ \o ->
        File
            <$> o
            .: "filename"
            <*> o
            .: "status"
            <*> o
            .: "raw_url"

data EmailConfig = EmailConfig
    { eName :: Text
    , eEmail :: Text
    , ePassword :: Text
    , eHost :: Text
    , eDestination :: Text
    }
    deriving (Show)

instance FromJSON EmailConfig where
    parseJSON = withObject "EmailConfig" $ \o ->
        EmailConfig
            <$> o
            .: "name"
            <*> o
            .: "email"
            <*> o
            .: "password"
            <*> o
            .: "host"
            <*> o
            .: "destination"