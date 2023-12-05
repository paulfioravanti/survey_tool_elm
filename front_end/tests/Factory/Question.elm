module Factory.Question exposing
    ( listOfSomeInvalidQuestions
    , listOfValidQuestions
    )

import Question.Model exposing (Question)
import SurveyResponse.Model exposing (SurveyResponse)


listOfSomeInvalidQuestions : List Question
listOfSomeInvalidQuestions =
    [ Question
        "Arrays start at 1"
        [ SurveyResponse 1 1 1 "5"
        , SurveyResponse 2 1 2 "-1"
        , SurveyResponse 3 1 3 "4"
        , SurveyResponse 4 1 4 ""
        , SurveyResponse 5 1 5 "1"
        ]
        "ratingquestion"
    , Question
        "I can quit Vim"
        [ SurveyResponse 6 2 1 "0"
        , SurveyResponse 7 2 2 "1"
        , SurveyResponse 8 2 3 "6"
        , SurveyResponse 9 2 4 "1"
        , SurveyResponse 10 2 5 "invalid"
        ]
        "ratingquestion"
    ]


listOfValidQuestions : List Question
listOfValidQuestions =
    [ Question
        "Arrays start at 1"
        [ SurveyResponse 1 1 1 "5"
        , SurveyResponse 2 1 2 "4"
        , SurveyResponse 3 1 3 "4"
        , SurveyResponse 4 1 4 "2"
        , SurveyResponse 5 1 5 "1"
        ]
        "ratingquestion"
    , Question
        "I can quit Vim"
        [ SurveyResponse 6 2 1 "3"
        , SurveyResponse 7 2 2 "4"
        , SurveyResponse 8 2 3 "5"
        , SurveyResponse 9 2 4 "1"
        , SurveyResponse 10 2 5 "1"
        ]
        "ratingquestion"
    ]
