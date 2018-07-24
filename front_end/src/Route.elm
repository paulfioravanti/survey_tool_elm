module Route exposing (Route(..))


type Route
    = ListSurveyResults
    | NotFound
    | SurveyResultDetail String
