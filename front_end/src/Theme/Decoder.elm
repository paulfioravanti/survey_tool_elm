module Theme.Decoder exposing (decoder)

import Json.Decode as Decode exposing (field, list, string)
import Json.Decode.Extra exposing ((|:))
import Question.Decoder
import Theme.Model exposing (Theme)


{-| Decodes a JSON theme.
-}
decoder : Decode.Decoder Theme
decoder =
    let
        question =
            Question.Decoder.decoder
    in
        Decode.succeed
            Theme
            |: field "name" string
            |: field "questions" (list question)
