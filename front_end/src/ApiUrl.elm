module ApiUrl exposing (init)

import Flags exposing (Flags)
import Json.Decode as Decode exposing (Value)


{-| Returns an API url to use when fetching survey information from the back
end, with appropriate fallbacks per environment when the url is unable to be
determined.

    import Json.Encode exposing (null, string)
    import Flags exposing (Flags)

    emptyFlags : Flags
    emptyFlags =
        { apiUrl = null
        , environment = null
        , language = null
        }

    init emptyFlags
    --> "https://survey-tool-back-end.herokuapp.com/survey_results/"

    flagsWithApiUrl : Flags
    flagsWithApiUrl =
        { emptyFlags | apiUrl = string "www.example.com/endpoint" }

    init flagsWithApiUrl
    --> "www.example.com/endpoint"

    flagsForDevelopmentEnvWithoutApiUrl : Flags
    flagsForDevelopmentEnvWithoutApiUrl =
        { emptyFlags | environment = string "development" }

    init flagsForDevelopmentEnvWithoutApiUrl
    --> "http://localhost:4000/survey_results/"

    flagsForProductionEnvWithoutApiUrl : Flags
    flagsForProductionEnvWithoutApiUrl =
        { emptyFlags | environment = string "production" }

    init flagsForProductionEnvWithoutApiUrl
    --> "https://survey-tool-back-end.herokuapp.com/survey_results/"

-}
init : Flags -> String
init { apiUrl, environment } =
    apiUrl
        |> Decode.decodeValue Decode.string
        |> Result.withDefault (determineUrlFromEnvironment environment)



-- PRIVATE


determineUrlFromEnvironment : Value -> String
determineUrlFromEnvironment environmentFlag =
    let
        environment =
            environmentFlag
                |> Decode.decodeValue Decode.string
    in
    case environment of
        Ok "development" ->
            defaultDevelopmentUrl

        _ ->
            defaultProductionUrl


defaultDevelopmentUrl : String
defaultDevelopmentUrl =
    "http://localhost:4000/survey_results/"


defaultProductionUrl : String
defaultProductionUrl =
    "https://survey-tool-back-end.herokuapp.com/survey_results/"
