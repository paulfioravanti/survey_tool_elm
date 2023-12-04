module Factory.Flags exposing
    ( emptyFlags
    , flagsWithApiUrl
    , flagsWithEnvironment
    )

import Flags exposing (Flags)
import Json.Encode exposing (null, string)


emptyFlags : Flags
emptyFlags =
    { apiUrl = null
    , environment = null
    , language = null
    }


flagsWithApiUrl : String -> Flags
flagsWithApiUrl apiUrl =
    { apiUrl = string apiUrl
    , environment = null
    , language = null
    }


flagsWithEnvironment : String -> Flags
flagsWithEnvironment environment =
    { apiUrl = null
    , environment = string environment
    , language = null
    }
