module UrlRequest.Fuzzer exposing (fuzzer)

import Browser exposing (UrlRequest)
import Fuzz exposing (Fuzzer)
import Random
import Shrink
import Url.Factory as Factory


fuzzer : Fuzzer UrlRequest
fuzzer =
    let
        generator : Random.Generator UrlRequest
        generator =
            Random.int 0 1
                |> Random.map
                    (\int ->
                        case int of
                            0 ->
                                Browser.Internal (Factory.urlWithPath "/")

                            1 ->
                                Browser.External "https://www.example.com"

                            _ ->
                                Browser.External "https://www.example.com"
                    )

        shrinker : Shrink.Shrinker UrlRequest
        shrinker urlRequest =
            Shrink.noShrink urlRequest
    in
    Fuzz.custom generator shrinker
