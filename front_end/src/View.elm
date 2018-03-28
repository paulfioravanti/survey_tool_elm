module View exposing (view)

import Controller
import Html exposing (Html, main_)
import Model exposing (Model)
import Messages exposing (Msg)


view : Model -> Html Msg
view model =
    main_ []
        [ Controller.render model ]
