module Fuzzer.Http.Response exposing (fuzzer)

import Dict
import Fuzz exposing (Fuzzer, int, string)
import Http


type alias Status =
    { code : Int
    , message : String
    }


{-| A Http.Response looks like:

type alias Response body =
    { url : String
    , status : { code : Int
    , message : String }
    , headers : Dict String String
    , body : body
    }

-}
fuzzer : Fuzzer (Http.Response String)
fuzzer =
    let
        status =
            Fuzz.map Status int
                |> Fuzz.andMap string

        headers =
            Fuzz.tuple ( string, string )
                |> Fuzz.list
                |> Fuzz.map Dict.fromList
    in
        Fuzz.map Http.Response string
            |> Fuzz.andMap status
            |> Fuzz.andMap headers
            |> Fuzz.andMap string
