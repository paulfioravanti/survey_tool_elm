module Config exposing (Config, init)

import Flags exposing (Flags)


type alias Config =
    { apiUrl : String
    }


init : Flags -> Config
init flags =
    let
        apiUrl =
            case flags.environment of
                "production" ->
                    "https://survey-tool-back-end.herokuapp.com/survey_results"

                _ ->
                    if String.isEmpty flags.apiUrl then
                        "http://localhost:4000/survey_results"
                    else
                        flags.apiUrl
    in
        { apiUrl = apiUrl }
