module Messages exposing (Msg(..))

import Navigation
import SurveyResultList.Messages


type Msg
    = SurveyResultListMsg SurveyResultList.Messages.Msg
    | UrlChange Navigation.Location
