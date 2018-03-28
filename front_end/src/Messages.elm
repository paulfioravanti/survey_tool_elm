module Messages exposing (Msg(..))

import Navigation
import Routes exposing (Route)
import SurveyResultList.Messages


type Msg
    = SurveyResultListMsg SurveyResultList.Messages.Msg
    | UrlChange Navigation.Location
    | UpdatePage ()
