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
