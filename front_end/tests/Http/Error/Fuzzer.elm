module Http.Error.Fuzzer exposing (fuzzer)

import Fuzz exposing (Fuzzer)
import Http


fuzzer : Fuzzer Http.Error
fuzzer =
    Fuzz.map
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
        (Fuzz.intRange 0 4)
