module Msg exposing (Msg(..))

import Routing.Msg
import SurveyResultList.Msg


type Msg
    = SurveyResultListMsg SurveyResultList.Msg.Msg
    | RoutingMsg Routing.Msg.Msg
    | UpdatePage ()
