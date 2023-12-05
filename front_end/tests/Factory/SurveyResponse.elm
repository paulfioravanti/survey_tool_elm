module Factory.SurveyResponse exposing
    ( listOfSomeInvalidSurveyResponses
    , listOfValidSurveyResponses
    )

import SurveyResponse.Model exposing (SurveyResponse)


listOfSomeInvalidSurveyResponses : List SurveyResponse
listOfSomeInvalidSurveyResponses =
    [ SurveyResponse 1 1 1 "5"
    , SurveyResponse 2 1 2 "-1"
    , SurveyResponse 3 1 3 "0"
    , SurveyResponse 4 1 4 ""
    , SurveyResponse 5 1 5 "6"
    , SurveyResponse 5 1 5 "invalid"
    ]


listOfValidSurveyResponses : List SurveyResponse
listOfValidSurveyResponses =
    [ SurveyResponse 1 1 1 "5"
    , SurveyResponse 2 1 2 "4"
    , SurveyResponse 3 1 3 "4"
    , SurveyResponse 4 1 4 "2"
    , SurveyResponse 5 1 5 "1"
    ]
