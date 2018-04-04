module Theme.Model exposing (Theme)

import Question.Model exposing (Question)


type alias Theme =
    { name : String
    , questions : List Question
    }
