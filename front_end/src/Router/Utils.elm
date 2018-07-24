module Router.Utils exposing (toRoute, toPath)

{-| Utility functions for routing.
-}

import Navigation exposing (Location)
import Route exposing (Route(ListSurveyResults, NotFound, SurveyResultDetail))
import UrlParser exposing (Parser, (</>), map, oneOf, s, string, top)


{-| Translates a Navigation.Location into a Route

    import Navigation exposing (Location)
    import Route exposing (Route(..))

    location : String -> Location
    location path =
        Location
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
    --> ListSurveyResults

    toRoute (location "/survey_results")
    --> ListSurveyResults

    toRoute (location "/survey_results/1")
    --> SurveyResultDetail "1"

    toRoute (location "/invalid")
    --> NotFound

-}
toRoute : Location -> Route
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
                NotFound


{-| Translates a Route into a URL

    import Route exposing (Route(..))

    toPath ListSurveyResults
    --> "/survey_results"

    toPath (SurveyResultDetail "10")
    --> "/survey_results/10"

    toPath NotFound
    --> "/not-found"

-}
toPath : Route -> String
toPath route =
    case route of
        ListSurveyResults ->
            "/survey_results"

        SurveyResultDetail id ->
            "/survey_results/" ++ id

        NotFound ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map ListSurveyResults top
        , map ListSurveyResults (s "survey_results")
        , map SurveyResultDetail (s "survey_results" </> string)
        ]
