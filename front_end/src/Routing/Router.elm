module Routing.Router exposing (toRoute, toPath)

import Navigation
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import UrlParser exposing (Parser, (</>), map, oneOf, s, string, top)


{-| Translates a Navigation.Location into a Route

    import Factory.Navigation.Location as Location
    import Routing.Route exposing (Route(..))

    toRoute (Location.factory "/")
    --> ListSurveyResultsRoute

    toRoute (Location.factory "/survey_results")
    --> ListSurveyResultsRoute

    toRoute (Location.factory "/survey_results/1")
    --> SurveyResultDetailRoute "1"

    toRoute (Location.factory "/invalid")
    --> NotFoundRoute

-}
toRoute : Navigation.Location -> Route
toRoute location =
    let
        route =
            location
                |> UrlParser.parsePath matchers
    in
        case route of
            Just route ->
                route

            Nothing ->
                NotFoundRoute


{-| Translates a Route into a URL

    import Routing.Route exposing (Route(..))

    toPath ListSurveyResultsRoute
    --> "/survey_results"

    toPath (SurveyResultDetailRoute "10")
    --> "/survey_results/10"

    toPath NotFoundRoute
    --> "/not-found"

-}
toPath : Route -> String
toPath route =
    case route of
        ListSurveyResultsRoute ->
            "/survey_results"

        SurveyResultDetailRoute id ->
            "/survey_results/" ++ id

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ListSurveyResultsRoute top
        , map ListSurveyResultsRoute (s "survey_results")
        , map SurveyResultDetailRoute (s "survey_results" </> string)
        ]
