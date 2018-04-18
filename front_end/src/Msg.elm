module Msg exposing (Msg(..))

import Routing.Msg
import SurveyResultDetail
import SurveyResultList


type Msg
    = SurveyResultDetailMsg SurveyResultDetail.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Routing.Msg.Msg
    | UpdatePage ()
