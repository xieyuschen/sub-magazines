module Auth where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Except
import System.Environment (getEnv)

getEnvWithCheck :: String -> (String -> Bool) -> ExceptT String IO String
getEnvWithCheck envName check = do
    env <- liftIO (getEnv envName)
    if check env
        then return env
        else throwE "Not find TOKEN_GITHUB inside environment variables"

getGithubKey :: ExceptT String IO String
getGithubKey = getEnvWithCheck "TOKEN_GITHUB" (not . null)

getEmailConfig :: ExceptT String IO String
getEmailConfig = getEnvWithCheck "SMTP_CONFIG" (not . null)