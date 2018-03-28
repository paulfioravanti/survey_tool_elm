module Msg exposing (Msg(..))

import Navigation
import Routes exposing (Route)
import SurveyResultList.Msg


type Msg
    = SurveyResultListMsg SurveyResultList.Msg.Msg
    | UrlChange Navigation.Location
    | UpdatePage ()
