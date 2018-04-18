module Router.Utils exposing (toRoute, toPath)

{-| Utility functions for routing.
-}

import Navigation
import Router.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import UrlParser exposing (Parser, (</>), map, oneOf, s, string, top)


{-| Translates a Navigation.Location into a Route

    import Navigation
    import Router.Route exposing (Route(..))

    location : String -> Navigation.Location
    location path =
        Navigation.Location
            ""
            ""
            ""
            ""
            ""
            ""
            path
            ""
            ""
            ""
            ""

    toRoute (location "/")
    --> ListSurveyResultsRoute

    toRoute (location "/survey_results")
    --> ListSurveyResultsRoute

    toRoute (location "/survey_results/1")
    --> SurveyResultDetailRoute "1"

    toRoute (location "/invalid")
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

    import Router.Route exposing (Route(..))

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
