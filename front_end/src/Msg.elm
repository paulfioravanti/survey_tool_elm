module Msg exposing (Msg(..))

import Router
import SurveyResultDetail
import SurveyResultList


type Msg
    = SurveyResultDetailMsg SurveyResultDetail.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Router.Msg
    | UpdatePage ()
