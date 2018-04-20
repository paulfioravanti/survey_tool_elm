module Config exposing (Config, init)

import ApiUrl
import Flags exposing (Flags)
import Locale exposing (Language)


type alias Config =
    { apiUrl : String
    , language : Language
    }


init : Flags -> Config
init flags =
    let
        apiUrl =
            case flags.environment of
                "production" ->
                    ApiUrl.productionUrl

                _ ->
                    ApiUrl.nonProductionUrl flags.apiUrl

        language =
            Locale.init flags.language
    in
        { apiUrl = apiUrl
        , language = language
        }
