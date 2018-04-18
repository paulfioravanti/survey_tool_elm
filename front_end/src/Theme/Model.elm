module Theme.Model exposing (Theme)

import Question exposing (Question)


type alias Theme =
    { name : String
    , questions : List Question
    }
