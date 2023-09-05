{-# LANGUAGE OverloadedStrings #-}

module UtilSpec where

import Common (emailConfigJsonStr, githubCommitDetailJsonStr)
import Control.Applicative (Applicative (liftA2))
import Data (Author (date), Commit (author), CommitDetail (commit, files), EmailConfig (eDestination, eEmail, eHost, eName, ePassword), File (File, raw_url, status))
import Data.Aeson (decode)
import Data.ByteString.Lazy.UTF8 as BLU (fromString)
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time
import Test.Hspec (Spec, describe, it, shouldBe)
import Util (getAddedEpubLinks, isAddedEpub, withinOneDay)

spec :: Spec
spec = do
    describe "test Util" $ do
        describe "test withinOneDay logic is correct" $ do
            it "the same time should return false" $ do
                withinOneDay oct2700 oct2700 `shouldBe` False
            it "half day later should return true" $ do
                withinOneDay oct2700 oct2612 `shouldBe` True
            it "two days later should return false" $ do
                withinOneDay oct2700 oct2500 `shouldBe` False
            it "half day ealier should return false" $ do
                withinOneDay oct2612 oct2700 `shouldBe` False
            it "two days ealier should return false" $ do
                withinOneDay oct2500 oct2700 `shouldBe` False
        describe "test isAddedEpub logic is correct" $ do
            it "added pdf file" $ do
                isAddedEpub (File "test.pdf" "added" "test.pdf") `shouldBe` False
            it "modified pdf file" $ do
                isAddedEpub (File "test.pdf" "modified" "test.pdf") `shouldBe` False
            it "unkonwn pdf file" $ do
                isAddedEpub (File "test.pdf" "xxx" "test.pdf") `shouldBe` False
            it "added epub file" $ do
                isAddedEpub (File "test.epub" "added" "test.epub") `shouldBe` True
            it "added epub file with .epub suffix only" $ do
                isAddedEpub (File "test.epub" "added" ".epub") `shouldBe` True
            it "added epub file with epub suffix only" $ do
                isAddedEpub (File "test.epub" "added" "epub") `shouldBe` False
            it "added epub file with abnormal chars" $ do
                isAddedEpub (File "test.epub" "added" "tA@3$:.]!t.epub") `shouldBe` True
            it "added epub file with real link" $ do
                let url = "https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.epub"
                isAddedEpub (File "test.epub" "added" url) `shouldBe` True
            it "modified epub file" $ do
                isAddedEpub (File "test.epub" "modified" "test.epub") `shouldBe` False
            it "unkonwn epub file" $ do
                isAddedEpub (File "test.epub" "xxx" "test.epub") `shouldBe` False
            it "added no-prefix file" $ do
                isAddedEpub (File "testepub" "added" "testepub") `shouldBe` False
            it "added no-prefix file" $ do
                isAddedEpub (File "test-epubepub" "added" "testepub") `shouldBe` False

        describe "test getAddedEpubLinks logic is correct" $ do
            let maybeGithubCommit = decode $ fromString githubCommitDetailJsonStr :: Maybe CommitDetail
            case maybeGithubCommit of
                Just githubCommitDetail -> do
                    it "getAddedEpubLinks get three correct link" $ do
                        let expection =
                                [ "https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/04_atlantic%2F2023.09.02%2FAtlantic_2023.09.02.epub"
                                , "https://github.com/hehonghui/awesome-english-ebooks/raw/44f9460c97accd8b003bff4060f6ed5760cf62f3/05_wired%2F2023.09.02%2Fwired_2023.09.02.epub"
                                ]
                        getAddedEpubLinks githubCommitDetail `shouldBe` expection
                Nothing -> do
                    it "check nothing" False

oct2700 :: UTCTime
oct2700 = UTCTime (fromGregorian 2018 10 27) (secondsToDiffTime 0)

oct2612 :: UTCTime
oct2612 = UTCTime (fromGregorian 2018 10 26) (secondsToDiffTime 12 * 60 * 60)

oct2500 :: UTCTime
oct2500 = UTCTime (fromGregorian 2018 10 25) (secondsToDiffTime 0)