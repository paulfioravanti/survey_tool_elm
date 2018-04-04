module Fuzzer.Navigation.Location exposing (fuzzer)

import Fuzz exposing (Fuzzer, constant, string)
import Navigation


{-| A Navigation.Location looks like:

{ href : String
, host : String
, hostname : String
, protocol : String
, origin : String
, port_ : String
, pathname : String
, search : String
, hash : String
, username : String
, password : String
}

UrlParser.parsePath only looks at the `pathname` value, so that is
where the url pathname value needs to be placed so these fuzzers can
be used in tests that involve routing.

-}
fuzzer : Fuzzer Navigation.Location
fuzzer =
    Fuzz.map Navigation.Location string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
        |> Fuzz.andMap string
