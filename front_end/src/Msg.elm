module Msg exposing
    ( Msg(..)
    , changeLanguage
    , changeRoute
    , languageSelector
    , surveyResult
    , surveyResultList
    , urlChanged
    , urlRequested
    )

import Browser exposing (UrlRequest)
import Language exposing (Language)
import LanguageSelector
import Route exposing (Route)
import SurveyResult
import SurveyResultList
import Url exposing (Url)


type Msg
    = ChangeLanguage Language
    | ChangeRoute Route
    | LanguageSelector LanguageSelector.Msg
    | SurveyResult SurveyResult.Msg
    | SurveyResultList SurveyResultList.Msg
    | UrlChanged Url
    | UrlRequested UrlRequest


changeLanguage : Language -> Msg
changeLanguage language =
    ChangeLanguage language


changeRoute : Route -> Msg
changeRoute route =
    ChangeRoute route


languageSelector : LanguageSelector.Msg -> Msg
languageSelector languageSelectorMsg =
    LanguageSelector languageSelectorMsg


surveyResult : SurveyResult.Msg -> Msg
surveyResult surveyResultMsg =
    SurveyResult surveyResultMsg


surveyResultList : SurveyResultList.Msg -> Msg
surveyResultList surveyResultListMsg =
    SurveyResultList surveyResultListMsg


urlChanged : Url -> Msg
urlChanged url =
    UrlChanged url


urlRequested : UrlRequest -> Msg
urlRequested urlRequest =
    UrlRequested urlRequest
