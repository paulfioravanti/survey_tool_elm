module Model exposing (Model, changeLanguage, init)

import ApiUrl
import Browser.Navigation exposing (Key)
import Flags exposing (Flags)
import Language exposing (Language)
import LanguageSelector exposing (LanguageSelector)
import Navigation exposing (Navigation)
import RemoteData exposing (WebData)
import Route
import SurveyResult exposing (SurveyResult)
import SurveyResultList exposing (SurveyResultList)
import Title
import Url exposing (Url)


type alias Model =
    { apiUrl : String
    , language : Language
    , languageSelector : LanguageSelector
    , navigation : Navigation
    , surveyResultDetail : WebData SurveyResult
    , surveyResultList : WebData SurveyResultList
    , title : String
    }


init : Flags -> Url -> Maybe Key -> Model
init flags url key =
    let
        route =
            Route.init url

        language =
            Language.init flags.language
    in
    { apiUrl = ApiUrl.init flags
    , language = language
    , languageSelector = LanguageSelector.init language
    , navigation = Navigation.init key route
    , surveyResultDetail = SurveyResult.init
    , surveyResultList = SurveyResultList.init
    , title = Title.init route language
    }


changeLanguage : Language -> Model -> Model
changeLanguage language model =
    let
        languageSelector =
            LanguageSelector.updateSelectableLanguages
                language
                model.languageSelector
    in
    { model
        | language = language
        , languageSelector = languageSelector
    }
