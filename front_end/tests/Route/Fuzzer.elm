module Route.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Random
import Route exposing (Route)
import Shrink


fuzzer : Fuzzer Route
fuzzer =
    let
        generator : Random.Generator Route
        generator =
            Random.int 0 1
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                Route.SurveyResultList

                            1 ->
                                Route.SurveyResultDetail "1"

                            _ ->
                                Route.SurveyResultList
                    )

        shrinker : Shrink.Shrinker Route
        shrinker route =
            Shrink.noShrink route
    in
    Fuzz.custom generator shrinker
