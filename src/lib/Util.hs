module Util where

import Control.Applicative (Applicative (liftA2))
import Data (Author (date), Commit (author), CommitDetail (commit, files), EmailConfig, File (raw_url, status))
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Time (UTCTime, addUTCTime, nominalDay)
import Prelude hiding (log)

-- timeWithinOneDay checks if the first time is later than the second time
-- but earlier than 1 day later than the second time.
withinOneDay :: UTCTime -> UTCTime -> Bool
-- liftA2 lifts the Bool to a0 -> Bool which allows we to bind the expression together
withinOneDay = liftA2 (&&) <$> (>) <*> (<=) . addUTCTime (-nominalDay)

getAddedEpubLinks :: CommitDetail -> [Text]
getAddedEpubLinks info = raw_url <$> filter isAddedEpub (files info)

isAddedEpub :: File -> Bool
isAddedEpub = liftA2 (&&) (\x -> status x == Text.pack "added") (\x -> Text.isSuffixOf (raw_url x) $ Text.pack ".epub")