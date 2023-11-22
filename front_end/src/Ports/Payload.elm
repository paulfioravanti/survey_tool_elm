module Ports.Payload exposing (withTaggedData)

import Json.Encode as Encode exposing (Value)


withTaggedData : ( String, Value ) -> Value
withTaggedData ( tag, data ) =
    Encode.object
        [ ( "tag", Encode.string tag )
        , ( "data", data )
        ]
