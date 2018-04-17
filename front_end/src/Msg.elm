module Msg exposing (Msg(..))

import Routing.Msg
import SurveyResult
import SurveyResultList


type Msg
    = SurveyResultMsg SurveyResult.Msg
    | SurveyResultListMsg SurveyResultList.Msg
    | RoutingMsg Routing.Msg.Msg
    | UpdatePage ()
