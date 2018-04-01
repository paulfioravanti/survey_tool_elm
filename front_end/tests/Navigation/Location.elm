module Navigation.Location exposing (stub)

import Fuzz exposing (Fuzzer, float, int, string)
import Navigation
import SurveyResult.Model exposing (SurveyResult)


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
where the url pathname value needs to be placed so these records can
be used in Routing tests.

-}
stub : String -> Navigation.Location
stub pathname =
    Navigation.Location
        ""
        ""
        ""
        ""
        ""
        ""
        pathname
        ""
        ""
        ""
        ""
