module SurveyResultDetail.View exposing (view)

import Css
    exposing
        ( backgroundColor
        , borderColor
        , hover
        , rgb
        , visible
        , visibility
        )
import Css.Foreign exposing (children)
import Dict exposing (Dict)
import Html.Styled
    exposing
        ( Html
        , article
        , div
        , h1
        , h2
        , h3
        , main_
        , text
        )
import Html.Styled.Attributes exposing (attribute, class, css)
import Question.Model exposing (Question)
import Question.Utils
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResponse.Utils
import SurveyResult.Model exposing (SurveyResult)
import SurveyResultDetail.Tooltip as Tooltip
import Theme.Model exposing (Theme)
import Utils


view : msg -> SurveyResult -> Html msg
view msg surveyResult =
    let
        articleClasses =
            [ "center"
            , "flex flex-column"
            , "mw8"
            ]
                |> String.join " "
    in
        main_ []
            [ article
                [ attribute "data-name" "survey-result-detail"
                , class articleClasses
                ]
                [ h1 [ class "f1 avenir" ]
                    [ text surveyResult.name ]
                , div [ attribute "data-name" "participation-count" ]
                    [ div [ class "" ]
                        [ text "Participants" ]
                    , div [ class "" ]
                        [ text (toString surveyResult.participantCount) ]
                    ]
                , div [ attribute "data-name" "submitted-response-count" ]
                    [ div [ class "" ]
                        [ text "Responses" ]
                    , div [ class "" ]
                        [ text (toString surveyResult.submittedResponseCount) ]
                    ]
                , div [ attribute "data-name" "submitted-response-rate" ]
                    [ div [ class "" ]
                        [ text "Response Rate" ]
                    , div [ class "" ]
                        [ text
                            (Utils.toFormattedPercentage
                                surveyResult.responseRate
                            )
                        ]
                    ]
                , div [ attribute "data-name" "themes" ]
                    (List.map
                        themeView
                        (Maybe.withDefault [] surveyResult.themes)
                    )
                ]
            ]


themeView : Theme -> Html msg
themeView theme =
    div [ attribute "data-name" "theme" ]
        [ h2 [ class "" ]
            [ text theme.name ]
        , div [ attribute "data-name" "theme-average-score" ]
            [ text (Question.Utils.averageScore theme.questions) ]
        , div [ attribute "data-name" "questions" ]
            (List.map questionView theme.questions)
        ]


questionView : Question -> Html msg
questionView question =
    let
        ratings =
            [ "1", "2", "3", "4", "5" ]

        histogram =
            question.surveyResponses
                |> SurveyResponse.Utils.respondentHistogram

        averageScore =
            question.surveyResponses
                |> SurveyResponse.Utils.averageScore
    in
        div [ attribute "data-name" "question" ]
            [ h3 [ class "" ]
                [ text question.description ]
            , div [ attribute "data-name" "question-average-score" ]
                [ text averageScore ]
            , div
                [ attribute "data-name" "survey-responses"
                , class "inline-flex"
                ]
                (List.map
                    (surveyResponseView histogram)
                    ratings
                )
            ]


surveyResponseView : Dict String (List Int) -> String -> Html msg
surveyResponseView histogram rating =
    let
        surveyResponseClasses =
            [ "dt"
            , "mh1"
            ]
                |> String.join " "

        responseContentClasses =
            [ "b--light-silver"
            , "ba"
            , "bg-moon-gray"
            , "br4"
            , "dtc"
            , "h2"
            , "hover-white"
            , "pointer"
            , "relative"
            , "tc"
            , "v-mid"
            , "w2"
            ]
                |> String.join " "
    in
        div
            [ attribute "data-name" "survey-response"
            , class surveyResponseClasses
            , css
                [ hover
                    [ children
                        [ Css.Foreign.class "hover-bg-brand"
                            [ backgroundColor (rgb 252 51 90) ]
                        ]
                    ]
                ]
            ]
            [ div
                [ attribute "data-name" "survey-response-content"
                , class responseContentClasses
                , class "hover-bg-brand"
                , css
                    [ hover
                        [ borderColor (rgb 252 51 90)
                        , children
                            [ Css.Foreign.class "survey-response-tooltip"
                                [ visibility visible ]
                            ]
                        ]
                    ]
                ]
                [ text rating
                , Tooltip.view histogram rating
                ]
            ]
