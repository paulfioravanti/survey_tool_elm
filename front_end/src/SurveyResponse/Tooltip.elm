module SurveyResponse.Tooltip exposing (view)

{-| Creates content for a tooltip on a survey response from a histogram
of respondent IDs and their responses.
-}

import Dict exposing (Dict)
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Styles


view : String -> Dict String (List Int) -> Html msg
view rating histogram =
    let
        ( attributeName, respondents ) =
            histogram
                |> respondentsByResponseContent rating

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
            [ attribute "data-name" attributeName
            , class classes
            , class "survey-response-tooltip"
            , css [ Styles.tooltip ]
            ]
            [ text respondents ]


respondentsByResponseContent :
    String
    -> Dict String (List Int)
    -> ( String, String )
respondentsByResponseContent responseContent histogram =
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

        attributeName =
            "survey-response-tooltip-"
    in
        if List.isEmpty respondents then
            ( attributeName ++ "no-respondents"
            , "Chosen by no respondents."
            )
        else if List.length respondents == 1 then
            ( attributeName ++ "one-respondent"
            , (displaySingleRespondent respondents)
            )
        else if head == respondents then
            ( attributeName ++ "all-respondents"
            , (displayAllRespondents head)
            )
        else
            truncatedRespondents head tail


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


truncatedRespondents : List Int -> List Int -> ( String, String )
truncatedRespondents respondentsToDisplay truncatedRespondents =
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

        attribute =
            if numTruncated == 1 then
                "survey-response-tooltip-one-truncated-respondent"
            else
                "survey-response-tooltip-multiple-truncated-respondents"
    in
        ( attribute
        , "Chosen by respondent IDs "
            ++ idsToDisplay
            ++ ", and "
            ++ toString numTruncated
            ++ others
        )
