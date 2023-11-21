module Route.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Route exposing (Route)


fuzzer : Fuzzer Route
fuzzer =
    Fuzz.map
        (\int ->
            case int of
                0 ->
                    Route.SurveyResultList

                1 ->
                    Route.SurveyResultDetail "1"

                _ ->
                    Route.SurveyResultList
        )
        (Fuzz.intRange 0 1)
