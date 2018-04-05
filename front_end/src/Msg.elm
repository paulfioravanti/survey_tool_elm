module Msg exposing (Msg(..))

import Routing.Msg
import SurveyResult.Msg
import SurveyResultList.Msg


type Msg
    = SurveyResultMsg SurveyResult.Msg.Msg
    | SurveyResultListMsg SurveyResultList.Msg.Msg
    | RoutingMsg Routing.Msg.Msg
    | UpdatePage ()
