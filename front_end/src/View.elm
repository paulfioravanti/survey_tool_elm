module View exposing (view)

import Html exposing (Html, main_)
import Model exposing (Model)
import Messages exposing (Msg)
import SurveyResultList.View


view : Model -> Html Msg
view model =
    main_ []
        [ SurveyResultList.View.view ]
