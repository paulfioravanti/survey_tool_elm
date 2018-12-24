module Theme.Encoder exposing (encode)

import Json.Encode as Encode
import Question.Encoder as Question
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
