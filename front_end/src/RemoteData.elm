module RemoteData exposing (RemoteData(..), WebData)

import Http


type RemoteData error data
    = NotRequested
    | Requesting
    | Failure error
    | Success data


type alias WebData data =
    RemoteData Http.Error data
