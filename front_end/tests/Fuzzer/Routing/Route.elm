module Fuzzer.Routing.Route exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Random.Pcg as Random
import Routing.Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Shrink


fuzzer =
    let
        generator : Random.Generator Route
        generator =
            Random.int 0 2
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                ListSurveyResultsRoute

                            1 ->
                                (SurveyResultDetailRoute "id")

                            _ ->
                                NotFoundRoute
                    )

        shrinker : Shrink.Shrinker Route
        shrinker route =
            Shrink.noShrink route
    in
        Fuzz.custom generator shrinker
