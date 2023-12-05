module Encoder.Theme exposing (encode)

import Encoder.Question as Question
import Json.Encode as Encode
import Theme exposing (Theme)


encode : Theme -> Encode.Value
encode theme =
    Encode.object
        [ ( "name"
          , Encode.string theme.name
          )
        , ( "questions"
          , Encode.list Question.encode theme.questions
          )
        ]
