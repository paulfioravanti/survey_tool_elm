module Data exposing (fetch)

import Http
import Json.Decode exposing (Decoder)
import RemoteData exposing (WebData)


fetch : String -> Decoder a -> (WebData a -> msg) -> Cmd msg
fetch apiUrl decoder callbackMsg =
    let
        response =
            Http.expectJson
                (\result -> callbackMsg (RemoteData.fromResult result))
                decoder
    in
    Http.get { url = apiUrl, expect = response }
