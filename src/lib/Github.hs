{-# LANGUAGE OverloadedStrings #-}

module Github where

import Data.Aeson (decode)
import qualified Data.String as BSU
import Network.HTTP.Client (BodyReader, Request (host, port, requestHeaders, secure), Response (responseBody), defaultRequest, httpLbs, newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)
import Network.HTTP.Simple (
    getResponseStatusCode,
    setRequestBearerAuth,
    setRequestMethod,
    setRequestPath,
 )

import Control.Applicative (Applicative (liftA2))
import Data (CommitDetail)
import Data.Time (UTCTime, addUTCTime, nominalDay)
import System.Console.GetOpt (ArgDescr (NoArg))
import UnliftIO.Exception (tryAny)

-- todo: refine code, how to use monad transformer instead of embedding a monad inside another
sendRequest :: String -> String -> IO (Maybe CommitDetail)
sendRequest repo bearerKey = do
    let request = setRequestBearerAuth (BSU.fromString bearerKey) $ constructMasterCommitReq repo
    manager <- newManager tlsManagerSettings
    errorOrResp <- tryAny $ httpLbs request manager
    case errorOrResp of
        Left e -> return Nothing
        Right res -> do
            let resCode = getResponseStatusCode res
            if resCode == 200
                then do
                    let bodyStr = responseBody res
                    return $ decode bodyStr
                else do
                    print resCode
                    return Nothing

constructMasterCommitReq :: String -> Request
constructMasterCommitReq repo =
    setRequestMethod "GET" $
        setRequestPath (BSU.fromString $ "repos/" ++ repo ++ "/commits/master") githubBaseRequest

githubBaseRequest :: Request
githubBaseRequest =
    defaultRequest
        { host = BSU.fromString "api.github.com"
        , port = 443
        , secure = True
        , requestHeaders =
            [ ("Content-Type", "application/json")
            , ("X-GitHub-Api-Version", "2022-11-28")
            , ("Accept", "application/vnd.github+json")
            , ("User-Agent", "Sub-magazines")
            ]
        }

-- timeWithinOneDay checks if the first time is later than the second time
-- but earlier than 1 day later than the second time.
withinOneDay :: UTCTime -> UTCTime -> Bool
-- liftA2 lifts the Bool to a0 -> Bool which allows we to bind the expression together
withinOneDay = liftA2 (&&) <$> (>) <*> (<=) . addUTCTime (-nominalDay)