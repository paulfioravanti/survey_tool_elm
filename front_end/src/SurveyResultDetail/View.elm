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
        , footer
        , h1
        , h2
        , h3
        , img
        , main_
        , span
        , text
        )
import Html.Styled.Attributes exposing (alt, attribute, class, css, src)
import Question.Model exposing (Question)
import Question.Utils
import Styles
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
            , "mw7"
            ]
                |> String.join " "

        logoClasses =
            [ "h2 h4-ns"
            , "img"
            , "mh0 mh2-ns"
            , "mt0 mv3-ns"
            ]
                |> String.join " "
    in
        main_ []
            [ article
                [ attribute "data-name" "survey-result-detail"
                , class articleClasses
                ]
                [ h1 [ class "f1 avenir tc dark-gray" ]
                    [ text surveyResult.name ]
                , div [ class "flex flex-row justify-between bg-light-gray br3 pa2 mv2" ]
                    [ div
                        [ attribute "data-name" "participation-count"
                        , class ""
                        ]
                        [ div [ class "f3 fw2" ]
                            [ text "Participants" ]
                        , div [ class "f3 tc b" ]
                            [ text (toString surveyResult.participantCount) ]
                        ]
                    , div
                        [ attribute "data-name" "submitted-response-count"
                        , class ""
                        ]
                        [ div [ class "f3 fw2" ]
                            [ text "Responses" ]
                        , div [ class "f3 tc b" ]
                            [ text (toString surveyResult.submittedResponseCount) ]
                        ]
                    , div
                        [ attribute "data-name" "submitted-response-rate"
                        , class ""
                        ]
                        [ div [ class "f3 fw2" ]
                            [ text "Response Rate" ]
                        , div [ class "f3 tc b" ]
                            [ text
                                (Utils.toFormattedPercentage
                                    surveyResult.responseRate
                                )
                            ]
                        ]
                    ]
                , div [ attribute "data-name" "themes" ]
                    (List.map
                        themeView
                        (Maybe.withDefault [] surveyResult.themes)
                    )
                ]
            , footer [ class "center tc b--light-gray b--dotted bt bb-0 br-0 bl-0 mw7 mt4" ]
                [ img [ src "/logo.png", class logoClasses, alt "logo" ] []
                ]
            ]


themeView : Theme -> Html msg
themeView theme =
    div [ attribute "data-name" "theme" ]
        [ div [ class "flex flex-row justify-between bb b--light-gray mv2" ]
            [ h2 [ class "dark-gray ttu f3" ]
                [ text theme.name ]
            , h2
                [ attribute "data-name" "theme-average-score"
                , class "b f3"
                ]
                [ span [ class "fw2 mr2" ]
                    [ text "Average " ]
                , text (Question.Utils.averageScore theme.questions)
                ]
            ]
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
            [ div [ class "flex flex-row justify-between mv2" ]
                [ h3 [ class "w-70 fw4" ]
                    [ text question.description ]
                , div [ class "flex-column" ]
                    [ h3
                        [ attribute "data-name" "question-average-score"
                        , class "tr"
                        ]
                        [ span [ class "fw1 mr2" ]
                            [ text "Average " ]
                        , text averageScore
                        ]
                    , div
                        [ attribute "data-name" "survey-responses"
                        , class "flex"
                        ]
                        (List.map
                            (surveyResponseView histogram)
                            ratings
                        )
                    ]
                ]
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
                        [ Css.Foreign.class "survey-response-content"
                            [ Styles.brandBackgroundColor ]
                        ]
                    ]
                ]
            ]
            [ div
                [ attribute "data-name" "survey-response-content"
                , class responseContentClasses
                , class "survey-response-content"
                , css
                    [ hover
                        [ Styles.brandBorderColor
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
