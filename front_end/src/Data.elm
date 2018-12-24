module Data exposing (fetch)

import Http
import Json.Decode exposing (Decoder)
import RemoteData exposing (WebData)


fetch : String -> Decoder a -> (WebData a -> msg) -> Cmd msg
fetch apiUrl decoder callbackMsg =
    let
        remoteData =
            callbackMsg << RemoteData.fromResult

        response =
            decoder
                |> Http.expectJson remoteData
    in
    Http.get { url = apiUrl, expect = response }
