port module Ports.Cmd exposing
    ( initBodyClasses
    , storeLanguage
    )

import Json.Encode as Encode exposing (Value)
import Ports.Payload as Payload


port outbound : Value -> Cmd msg


initBodyClasses : String -> Cmd msg
initBodyClasses classes =
    outbound (stringPayload "classes" "INIT_BODY_CLASSES" classes)


storeLanguage : String -> Cmd msg
storeLanguage language =
    outbound (stringPayload "language" "STORE_LANGUAGE" language)



-- PRIVATE


stringPayload : String -> String -> String -> Value
stringPayload objectKey payloadTag string =
    let
        data : Value
        data =
            Encode.object [ ( objectKey, Encode.string string ) ]
    in
    Payload.withTaggedData ( payloadTag, data )
