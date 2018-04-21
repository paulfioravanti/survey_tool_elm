module Config exposing (Config, init)

import ApiUrl
import Flags exposing (Flags)
import Json.Decode as Decode


type alias Config =
    { apiUrl : String }


init : Flags -> Config
init flags =
    let
        environment =
            elmEnvironment flags.environment

        apiUrl =
            case environment of
                "production" ->
                    ApiUrl.productionUrl

                _ ->
                    ApiUrl.nonProductionUrl flags.apiUrl
    in
        { apiUrl = apiUrl }


elmEnvironment : Decode.Value -> String
elmEnvironment environmentFlag =
    let
        environment =
            environmentFlag
                |> Decode.decodeValue Decode.string
    in
        case environment of
            Ok env ->
                env

            Err _ ->
                "production"
