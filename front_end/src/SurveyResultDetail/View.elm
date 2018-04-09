module SurveyResultDetail.View exposing (view)

import Dict exposing (Dict)
import Helpers
import Html
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
import Html.Attributes exposing (attribute, class, href)
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
                [ attribute "data-name" "survey-result"
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
    div [ attribute "data-name" "question" ]
        [ h3 [ class "" ]
            [ text question.description ]
        , div [ attribute "data-name" "question-average-score" ]
            [ text (questionAverageScore question.surveyResponses) ]
        , div [ attribute "data-name" "survey-responses-histogram" ]
            [ text (toString (surveyResponsesHistogram question.surveyResponses)) ]
        , div [ attribute "data-name" "1-response-tooltip" ]
            [ text (respondentsByResponseContent (surveyResponsesHistogram question.surveyResponses) "4") ]
        , div [ attribute "data-name" "survey-responses" ]
            (List.map surveyResponseView question.surveyResponses)
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
        numNamedIds =
            5

        respondents =
            histogram
                |> Dict.get responseContent
                |> Maybe.withDefault []

        ( head, tail ) =
            ( List.take numNamedIds respondents
            , List.drop numNamedIds respondents
            )

        rootMessage =
            head
                |> List.map toString
                |> String.join ", "
                |> (++) "Chosen by respondent IDs "
    in
        if List.isEmpty respondents then
            ""
        else if head == respondents then
            rootMessage
        else
            let
                tailLength =
                    List.length tail

                others =
                    if tailLength == 1 then
                        " other"
                    else
                        " others"
            in
                rootMessage
                    ++ ", and "
                    ++ toString tailLength
                    ++ others


surveyResponseView : SurveyResponse -> Html msg
surveyResponseView surveyResponse =
    div [ attribute "data-name" "survey-response" ]
        [ text surveyResponse.responseContent
        ]


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
