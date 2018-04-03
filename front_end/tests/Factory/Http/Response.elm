module Factory.Http.Response exposing (factory)

import Dict
import Http exposing (Response)


factory : String -> Response String
factory message =
    Response
        ""
        { code = 100, message = message }
        Dict.empty
        ""
