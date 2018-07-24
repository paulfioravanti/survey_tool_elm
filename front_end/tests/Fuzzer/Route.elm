module Fuzzer.Route exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Random.Pcg as Random
import Route exposing (Route(ListSurveyResults, NotFound, SurveyResultDetail))
import Shrink


fuzzer : Fuzzer Route
fuzzer =
    let
        generator : Random.Generator Route
        generator =
            Random.int 0 2
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                ListSurveyResults

                            1 ->
                                (SurveyResultDetail "id")

                            _ ->
                                NotFound
                    )

        shrinker : Shrink.Shrinker Route
        shrinker route =
            Shrink.noShrink route
    in
        Fuzz.custom generator shrinker
