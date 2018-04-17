module SurveyResult
    exposing
        ( Msg
        , SurveyResult
        , update
        )

import Html.Styled exposing (Html)
import RemoteData exposing (WebData)
import SurveyResult.Model as Model
import SurveyResult.Msg as Msg
import SurveyResult.Update as Update


type alias SurveyResult =
    Model.SurveyResult


type alias Msg =
    Msg.Msg


update : Msg -> ( WebData SurveyResult, Cmd Msg )
update msg =
    Update.update msg
