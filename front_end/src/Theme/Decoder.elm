module Theme.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, string)
import Json.Decode.Extra exposing ((|:))
import Theme.Model exposing (Theme)


{-| Decodes a JSON theme.
-}
decoder : Decode.Decoder Theme
decoder =
    Decode.succeed
        Theme
        |: field "name" string
