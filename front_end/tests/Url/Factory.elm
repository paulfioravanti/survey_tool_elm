module Url.Factory exposing (urlWithPath)

import Url exposing (Url)


urlWithPath : String -> Url
urlWithPath path =
    { protocol = Url.Https
    , host = "example.com"
    , port_ = Just 443
    , path = path
    , query = Nothing
    , fragment = Nothing
    }
