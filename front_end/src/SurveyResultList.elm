module SurveyResultList exposing
    ( Msg
    , SurveyResultList
    , init
    , load
    , path
    , title
    , update
    , view
    )

import Html.Styled exposing (Html)
import Language exposing (Language)
import RemoteData exposing (WebData)
import SurveyResultList.Cmd as Cmd
import SurveyResultList.Data as Data
import SurveyResultList.Model as Model
import SurveyResultList.Msg as Msg
import SurveyResultList.Path as Path
import SurveyResultList.Update as Update


type alias SurveyResultList =
    Model.SurveyResultList


type alias Msg =
    Msg.Msg


init : WebData SurveyResultList
init =
    Data.init


load : String -> WebData SurveyResultList -> Cmd Msg
load apiUrl surveyResultList =
    Cmd.load apiUrl surveyResultList


title : Language -> WebData SurveyResultList -> String
title language surveyResultList =
    Data.title language surveyResultList


path : String
path =
    Path.path


update : Language -> Msg -> ( WebData SurveyResultList, String, Cmd Msg )
update language msg =
    Update.update language msg


view : Language -> WebData SurveyResultList -> Html msg
view language webData =
    Data.view language webData
