module View exposing (view)

import Browser exposing (Document)
import Header
import Html.Styled as Html exposing (Html)
import Model exposing (Model)
import Msg exposing (Msg)
import Page.NotFound as NotFound
import RemoteData exposing (WebData)
import Route
import SurveyResult
import SurveyResultList


view : Model -> Document Msg
view model =
    let
        header : WebData a -> Html Msg
        header =
            Header.view
                Msg.changeLanguage
                Msg.languageSelector
                model.language
                model.languageSelector

        content : List (Html Msg)
        content =
            case model.navigation.route of
                Just Route.SurveyResultList ->
                    [ header model.surveyResultList
                    , SurveyResultList.view
                        model.language
                        model.surveyResultList
                    ]

                Just (Route.SurveyResultDetail _) ->
                    [ header model.surveyResultDetail
                    , SurveyResult.detailView
                        model.language
                        model.surveyResultDetail
                    ]

                Nothing ->
                    [ NotFound.view model.language ]
    in
    { title = model.title
    , body = List.map Html.toUnstyled content
    }
