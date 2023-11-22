module Data exposing (fetch)

import Http exposing (Expect)
import Json.Decode exposing (Decoder)
import RemoteData exposing (WebData)


fetch : String -> Decoder a -> (WebData a -> msg) -> Cmd msg
fetch apiUrl decoder callbackMsg =
    let
        response : Expect msg
        response =
            Http.expectJson
                (\result -> callbackMsg (RemoteData.fromResult result))
                decoder
    in
    Http.get { url = apiUrl, expect = response }
