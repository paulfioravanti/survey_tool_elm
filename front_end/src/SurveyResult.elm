module SurveyResult
    exposing
        ( Msg
        , SurveyResult
        , update
        , view
        )

import Html.Styled exposing (Html)
import RemoteData exposing (WebData)
import SurveyResult.Model as Model
import SurveyResult.Msg as Msg
import SurveyResult.Update as Update
import SurveyResult.View as View


type alias SurveyResult =
    Model.SurveyResult


type alias Msg =
    Msg.Msg


update : Msg -> ( WebData SurveyResult, Cmd Msg )
update msg =
    Update.update msg


view : (String -> msg) -> SurveyResult -> Html msg
view msg surveyResult =
    View.view msg surveyResult
