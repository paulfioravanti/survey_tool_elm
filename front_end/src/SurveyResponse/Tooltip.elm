module SurveyResponse.Tooltip exposing (view)

import Dict exposing (Dict)
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Styles


view : Dict String (List Int) -> String -> Html msg
view histogram rating =
    let
        classes =
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
    in
        span
            [ attribute "data-name" "survey-response-tooltip"
            , class classes
            , class "survey-response-tooltip"
            , css [ Styles.tooltip ]
            ]
            [ text (respondentsByResponseContent histogram rating) ]


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
    in
        if List.isEmpty respondents then
            "Chosen by no respondents."
        else if List.length respondents == 1 then
            displaySingleRespondent respondents
        else if head == respondents then
            displayAllRespondents head
        else
            displayTruncatedRespondents head tail


displaySingleRespondent : List Int -> String
displaySingleRespondent respondents =
    let
        id =
            respondents
                |> List.head
                |> Maybe.withDefault 0
                |> toString
    in
        "Chosen by respondent ID " ++ id ++ "."


displayAllRespondents : List Int -> String
displayAllRespondents respondents =
    let
        allExceptLast =
            (List.length respondents) - 1

        ( head, tail ) =
            ( List.take allExceptLast respondents
            , List.drop allExceptLast respondents
            )

        headIds =
            head
                |> List.map toString
                |> String.join ", "

        tailId =
            tail
                |> List.head
                |> Maybe.withDefault 0
                |> toString
    in
        "Chosen by respondent IDs " ++ headIds ++ ", and " ++ tailId ++ "."


displayTruncatedRespondents : List Int -> List Int -> String
displayTruncatedRespondents respondentsToDisplay truncatedRespondents =
    let
        idsToDisplay =
            respondentsToDisplay
                |> List.map toString
                |> String.join ", "

        numTruncated =
            List.length truncatedRespondents

        others =
            if numTruncated == 1 then
                " other."
            else
                " others."
    in
        "Chosen by respondent IDs "
            ++ idsToDisplay
            ++ ", and "
            ++ toString numTruncated
            ++ others
