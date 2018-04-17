module Config exposing (Config, init)

import Flags exposing (Flags)
import Json.Decode as Decode


type alias Config =
    { apiUrl : String
    }


init : Flags -> Config
init flags =
    let
        apiUrl =
            case flags.environment of
                "production" ->
                    productionApiUrl

                _ ->
                    nonProductionApiUrl flags.apiUrl
    in
        { apiUrl = apiUrl }


productionApiUrl : String
productionApiUrl =
    "https://survey-tool-back-end.herokuapp.com/survey_results"


nonProductionApiUrl : Decode.Value -> String
nonProductionApiUrl apiUrlFlag =
    let
        apiUrl =
            apiUrlFlag
                |> Decode.decodeValue Decode.string
    in
        case apiUrl of
            Ok url ->
                url

            Err _ ->
                "http://localhost:4000/survey_results"
