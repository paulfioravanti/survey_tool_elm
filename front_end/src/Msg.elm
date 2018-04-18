module Msg exposing (Msg(..))

import Router.Msg
import SurveyResultDetail
import SurveyResultList


type Msg
    = SurveyResultDetailMsg SurveyResultDetail.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Router.Msg.Msg
    | UpdatePage ()
