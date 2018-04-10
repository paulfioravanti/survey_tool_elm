module SurveyResultDetail.View exposing (view)

import Css exposing (..)
import Css.Foreign exposing (children)
import Dict exposing (Dict)
import Helpers
import Html.Styled
    exposing
        ( Html
        , a
        , article
        , div
        , h1
        , h2
        , h3
        , img
        , main_
        , p
        , section
        , span
        , text
        )
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Question.Model exposing (Question)
import Round
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResult.Model exposing (SurveyResult)
import Theme.Model exposing (Theme)


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
                            (Helpers.toFormattedPercentage
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
            [ text (themeAverageScore theme.questions) ]
        , div [ attribute "data-name" "questions" ]
            (List.map questionView theme.questions)
        ]


questionView : Question -> Html msg
questionView question =
    let
        ratings =
            [ "1", "2", "3", "4", "5" ]

        histogram =
            surveyResponsesHistogram question.surveyResponses
    in
        div [ attribute "data-name" "question" ]
            [ h3 [ class "" ]
                [ text question.description ]
            , div [ attribute "data-name" "question-average-score" ]
                [ text (questionAverageScore question.surveyResponses) ]
            , div
                [ attribute "data-name" "survey-responses"
                , class "inline-flex"
                ]
                (List.map
                    (surveyResponseView histogram)
                    ratings
                )
            ]


surveyResponsesHistogram : List SurveyResponse -> Dict String (List Int)
surveyResponsesHistogram surveyResponses =
    let
        histogram =
            Dict.fromList
                [ ( "1", [] )
                , ( "2", [] )
                , ( "3", [] )
                , ( "4", [] )
                , ( "5", [] )
                ]

        prependRatingToList { respondentId, responseContent } dict =
            if Dict.member responseContent dict then
                Dict.update
                    responseContent
                    (Maybe.map ((::) respondentId))
                    dict
            else
                dict
    in
        List.foldl prependRatingToList histogram surveyResponses


respondentsByResponseContent : Dict String (List Int) -> String -> String
respondentsByResponseContent histogram responseContent =
    let
        numIdsToDisplay =
            5

        respondents =
            histogram
                |> Dict.get responseContent
                |> Maybe.withDefault []

        ( head, tail ) =
            ( List.take numIdsToDisplay respondents
            , List.drop numIdsToDisplay respondents
            )

        participantIdsToDisplay =
            head
                |> List.map toString
                |> String.join ", "
    in
        if List.isEmpty respondents then
            "Chosen by no respondents."
        else if head == respondents then
            let
                headLength =
                    List.length head

                ( headHead, headTail ) =
                    ( List.take (headLength - 1) head
                    , List.drop (headLength - 1) head
                    )

                headIds =
                    headHead
                        |> List.map toString
                        |> String.join ", "

                tailId =
                    headTail
                        |> List.head
                        |> Maybe.withDefault 0
            in
                "Chosen by respondent IDs "
                    ++ headIds
                    ++ ", and "
                    ++ toString tailId
                    ++ "."
        else
            let
                tailLength =
                    List.length tail

                others =
                    if tailLength == 1 then
                        " other."
                    else
                        " others."
            in
                "Chosen by respondent IDs "
                    ++ participantIdsToDisplay
                    ++ ", and "
                    ++ toString tailLength
                    ++ others


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
                , surveyResponseTooltip histogram rating
                ]
            ]


surveyResponseTooltip : Dict String (List Int) -> String -> Html msg
surveyResponseTooltip histogram rating =
    let
        tooltipClasses =
            [ "absolute"
            , "avenir"
            , "bg-dark-gray"
            , "br3"
            , "f6"
            , "nl5"
            , "pa1"
            , "tc"
            , "w4"
            , "white"
            , "z-1"
            ]
                |> String.join " "

        styles =
            [ after
                [ borderColor4 (hex "000") transparent transparent transparent
                , borderStyle solid
                , borderWidth (px 5)
                , left (pct 50)
                , position absolute
                , property "content" "''"
                , top (pct 100)
                ]
            , bottom (pct 150)
            , left (pct 25)
            , visibility hidden
            ]
    in
        span
            [ attribute "data-name" "survey-response-tooltip"
            , class tooltipClasses
            , class "survey-response-tooltip"
            , css styles
            ]
            [ text (respondentsByResponseContent histogram rating) ]


themeAverageScore : List Question -> String
themeAverageScore questions =
    let
        themeSum =
            questions
                |> questionsSum
                |> toFloat

        themeSurveyResponseCount =
            questions
                |> questionsResponseCount
                |> toFloat
    in
        themeSurveyResponseCount
            |> (/) themeSum
            |> Round.round 2


addValidResponse : SurveyResponse -> Int -> Int
addValidResponse surveyResponse acc =
    let
        responseContent =
            surveyResponse.responseContent
                |> responseIntValue
    in
        if responseContent > 0 then
            acc + 1
        else
            acc


questionsResponseCount : List Question -> Int
questionsResponseCount questions =
    let
        addQuestionSurveyResponsesCount =
            (\question acc ->
                question.surveyResponses
                    |> List.foldl addValidResponse 0
                    |> (+) acc
            )
    in
        questions
            |> List.foldl addQuestionSurveyResponsesCount 0


questionAverageScore : List SurveyResponse -> String
questionAverageScore surveyResponses =
    let
        questionSum =
            surveyResponses
                |> responsesSum
                |> toFloat

        questionSurveyResponseCount =
            surveyResponses
                |> responseCount
                |> toFloat
    in
        questionSurveyResponseCount
            |> (/) questionSum
            |> Round.round 2


responseCount : List SurveyResponse -> Int
responseCount surveyResponses =
    surveyResponses
        |> List.foldl addValidResponse 0


questionsSum : List Question -> Int
questionsSum questions =
    let
        addQuestionsSum =
            (\question acc ->
                question.surveyResponses
                    |> responsesSum
                    |> (+) acc
            )
    in
        questions
            |> List.foldl addQuestionsSum 0


responsesSum : List SurveyResponse -> Int
responsesSum surveyResponses =
    let
        addResponseContent =
            (\surveyResponse acc ->
                surveyResponse.responseContent
                    |> responseIntValue
                    |> (+) acc
            )
    in
        surveyResponses
            |> List.foldl addResponseContent 0


responseIntValue : String -> Int
responseIntValue responseContent =
    responseContent
        |> String.toInt
        |> Result.withDefault 0
