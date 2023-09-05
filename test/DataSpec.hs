{-# LANGUAGE OverloadedStrings #-}

module DataSpec where

import Common (emailConfigJsonStr, githubCommitDetailJsonStr)
import Data (CommitDetail, EmailConfig (eDestination, eEmail, eHost, eName, ePassword))
import Data.Aeson (decode)
import Data.ByteString.Lazy.UTF8 as BLU (fromString)
import Test.Hspec (Spec, describe, it, shouldBe)

spec :: Spec
spec = do
    let maybeGithubCommit = decode $ fromString githubCommitDetailJsonStr :: Maybe CommitDetail
    let maybeEmailConfig = decode $ fromString emailConfigJsonStr :: Maybe EmailConfig
    describe "test the defined structures could be decode" $ do
        describe "github CommitDetail is defined correctly" $ do
            it "could be decode successfully" $ do
                case maybeGithubCommit of
                    Just _ -> True
                    Nothing -> False
        describe "email EmailConfig is defined correctly" $ do
            it "could be decode successfully" $ do
                case maybeEmailConfig of
                    Just _ -> True
                    Nothing -> False
            it "name could retrieve correctly" $ do
                let Just conf = maybeEmailConfig
                eName conf `shouldBe` "name"
            it "email could retrieve correctly" $ do
                let Just conf = maybeEmailConfig
                eEmail conf `shouldBe` "email@demo.com"
            it "password could retrieve correctly" $ do
                let Just conf = maybeEmailConfig
                ePassword conf `shouldBe` "password"
            it "host could retrieve correctly" $ do
                let Just conf = maybeEmailConfig
                eHost conf `shouldBe` "localhost"
            it "destination could retrieve correctly" $ do
                let Just conf = maybeEmailConfig
                eDestination conf `shouldBe` "destination"
