module Http.Error.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Http
import Random
import Shrink


fuzzer : Fuzzer Http.Error
fuzzer =
    let
        generator : Random.Generator Http.Error
        generator =
            Random.int 0 4
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                Http.BadUrl "http://www.example.com"

                            1 ->
                                Http.Timeout

                            2 ->
                                Http.NetworkError

                            3 ->
                                Http.BadStatus 500

                            4 ->
                                Http.BadBody "some bad body"

                            _ ->
                                Http.NetworkError
                    )

        shrinker : Shrink.Shrinker Http.Error
        shrinker httpError =
            Shrink.noShrink httpError
    in
    Fuzz.custom generator shrinker
