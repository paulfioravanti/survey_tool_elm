module Msg exposing (Msg(..))

import Http
import I18Next exposing (Translations)
import Router
import SurveyResultDetail
import SurveyResultList


type Msg
    = SurveyResultDetailMsg SurveyResultDetail.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | TranslationsLoaded (Result Http.Error Translations)
    | RoutingMsg Router.Msg
    | UpdatePage ()
