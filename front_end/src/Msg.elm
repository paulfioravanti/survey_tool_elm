module Msg exposing (Msg(..))

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
