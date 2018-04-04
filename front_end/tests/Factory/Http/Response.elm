module Factory.Http.Response exposing (factory)

import Dict
import Http exposing (Response)


{-| Not sure how to make this a fuzzer due to the nested record, so it can
   stay as a factory for now.
-}
factory : String -> Response String
factory message =
    Response
        ""
        { code = 100, message = message }
        Dict.empty
        ""
