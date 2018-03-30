module Routing.Route exposing (Route(..))


type Route
    = ListSurveyResultsRoute
    | NotFoundRoute
    | SurveyResultDetailRoute String
