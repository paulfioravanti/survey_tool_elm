module ApiUrl exposing (productionUrl, nonProductionUrl)

import Json.Decode as Decode exposing (Value)


nonProductionUrl : Value -> String
nonProductionUrl apiUrlFlag =
    let
        apiUrl =
            apiUrlFlag
                |> Decode.decodeValue Decode.string
    in
        case apiUrl of
            Ok url ->
                url

            Err _ ->
                "http://localhost:4000/survey_results/"


productionUrl : String
productionUrl =
    "https://survey-tool-back-end.herokuapp.com/survey_results/"
