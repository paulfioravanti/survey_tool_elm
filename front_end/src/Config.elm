module Config exposing (Config, init)

import ApiUrl
import Flags exposing (Flags)


type alias Config =
    { apiUrl : String }


init : Flags -> Config
init flags =
    let
        apiUrl =
            case flags.environment of
                "production" ->
                    ApiUrl.productionUrl

                _ ->
                    ApiUrl.nonProductionUrl flags.apiUrl
    in
        { apiUrl = apiUrl }
