module SurveyResultList
    exposing
        ( Msg
        , SurveyResultList
        , fetchSurveyResultList
        , update
        , view
        )

import Html.Styled exposing (Html)
import Locale exposing (Locale)
import RemoteData exposing (WebData)
import SurveyResultList.Cmd as Cmd
import SurveyResultList.Config exposing (Config)
import SurveyResultList.Controller as Controller
import SurveyResultList.Model as Model
import SurveyResultList.Msg as Msg
import SurveyResultList.Update as Update
import Translations exposing (Lang)


type alias SurveyResultList =
    Model.SurveyResultList


type alias Msg =
    Msg.Msg


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    Cmd.fetchSurveyResultList apiUrl


update : Msg -> Lang -> ( WebData SurveyResultList, Cmd Msg )
update msg language =
    Update.update msg language


view : Config msg -> Locale -> WebData SurveyResultList -> Html msg
view config locale surveyResultList =
    Controller.render config locale surveyResultList
