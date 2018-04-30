module Msg exposing (Msg(..))

import Locale
import Navigation exposing (Location)
import Router
import SurveyResultDetail
import SurveyResultList


type Msg
    = Blur
    | LocaleMsg Locale.Msg
    | SurveyResultDetailMsg SurveyResultDetail.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Router.Msg
    | UpdatePage Location
