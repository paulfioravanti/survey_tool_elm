module Route exposing (Route(..))


type Route
    = ListSurveyResultsRoute
    | NotFoundRoute
    | SurveyResultDetailRoute String
