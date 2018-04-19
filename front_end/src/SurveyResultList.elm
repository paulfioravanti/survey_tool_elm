module SurveyResultList
    exposing
        ( Msg
        , SurveyResultList
        , fetchSurveyResultList
        , update
        , view
        )

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import RemoteData exposing (WebData)
import SurveyResultList.Cmd as Cmd
import SurveyResultList.Controller as Controller
import SurveyResultList.Model as Model
import SurveyResultList.Msg as Msg
import SurveyResultList.Update as Update


type alias SurveyResultList =
    Model.SurveyResultList


type alias Msg =
    Msg.Msg


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    Cmd.fetchSurveyResultList apiUrl


update : Msg -> ( WebData SurveyResultList, Cmd Msg )
update msg =
    Update.update msg


view : (String -> msg) -> Translations -> WebData SurveyResultList -> Html msg
view msg translations surveyResultList =
    Controller.render msg translations surveyResultList
