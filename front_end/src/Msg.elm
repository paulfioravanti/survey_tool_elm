module Msg exposing (Msg(..))

import Routing.Msg
import SurveyResult.Msg
import SurveyResultList


type Msg
    = SurveyResultMsg SurveyResult.Msg.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Routing.Msg.Msg
    | UpdatePage ()
