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
import SurveyResultList.Model as Model exposing (Config)
import SurveyResultList.Msg as Msg
import SurveyResultList.Update as Update


type alias SurveyResultList =
    Model.SurveyResultList


type alias Msg =
    Msg.Msg


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    Cmd.fetchSurveyResultList apiUrl


update : Msg -> Translations -> ( WebData SurveyResultList, Cmd Msg )
update msg translations =
    Update.update msg translations


view : Config msg -> Translations -> WebData SurveyResultList -> Html msg
view config translations surveyResultList =
    Controller.render config translations surveyResultList
