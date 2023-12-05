module Fuzzer.UrlRequest exposing (fuzzer)

import Browser exposing (UrlRequest)
import Factory.Url as Factory
import Fuzz exposing (Fuzzer)


fuzzer : Fuzzer UrlRequest
fuzzer =
    Fuzz.map
        (\int ->
            case int of
                0 ->
                    Browser.Internal (Factory.urlWithPath "/")

                1 ->
                    Browser.External "https://www.example.com"

                _ ->
                    Browser.External "https://www.example.com"
        )
        (Fuzz.intRange 0 1)
