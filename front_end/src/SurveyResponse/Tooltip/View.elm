module SurveyResponse.Tooltip.View exposing (view)

import Dict
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Language exposing (Language)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import SurveyResponse.Tooltip.Styles as Styles
import Translations


view : Language -> String -> RespondentHistogram -> Html msg
view language rating histogram =
    let
        ( attributeName, respondents ) =
            respondentsByResponseContent language rating histogram
    in
    span
        [ attribute "data-name" attributeName
        , class Styles.tooltip
        , css [ Styles.tooltipCss ]
        ]
        [ text respondents ]


respondentsByResponseContent :
    Language
    -> String
    -> RespondentHistogram
    -> ( String, String )
respondentsByResponseContent language rating histogram =
    let
        numIdsToDisplay : Int
        numIdsToDisplay =
            5

        respondents : List String
        respondents =
            histogram
                |> Dict.get rating
                |> Maybe.withDefault []

        ( head, tail ) =
            ( List.take numIdsToDisplay respondents
            , List.drop numIdsToDisplay respondents
            )

        attributeName : String
        attributeName =
            "survey-response-tooltip-"
    in
    if List.isEmpty respondents then
        ( attributeName ++ "no-respondents"
        , Translations.noRespondents language
        )

    else if List.length respondents == 1 then
        ( attributeName ++ "one-respondent"
        , displaySingleRespondent language respondents
        )

    else if head == respondents then
        ( attributeName ++ "all-respondents"
        , displayAllRespondents language head
        )

    else
        truncatedRespondents language head tail


displaySingleRespondent : Language -> List String -> String
displaySingleRespondent language respondents =
    let
        id : String
        id =
            respondents
                |> List.head
                |> Maybe.withDefault "0"
    in
    Translations.oneRespondent language id


displayAllRespondents : Language -> List String -> String
displayAllRespondents language respondents =
    let
        allExceptLast : Int
        allExceptLast =
            List.length respondents - 1

        ( head, tail ) =
            ( List.take allExceptLast respondents
            , List.drop allExceptLast respondents
            )

        headIds : String
        headIds =
            String.join ", " head

        tailId : String
        tailId =
            tail
                |> List.head
                |> Maybe.withDefault "0"
    in
    Translations.allRespondents language headIds tailId


truncatedRespondents :
    Language
    -> List String
    -> List String
    -> ( String, String )
truncatedRespondents language respondentsToDisplay truncatedRespondentsList =
    let
        idsToDisplay : String
        idsToDisplay =
            String.join ", " respondentsToDisplay

        numTruncated : Int
        numTruncated =
            List.length truncatedRespondentsList

        others : String
        others =
            if numTruncated == 1 then
                Translations.other language

            else
                Translations.others language

        dataAttribute : String
        dataAttribute =
            if numTruncated == 1 then
                "survey-response-tooltip-one-truncated-respondent"

            else
                "survey-response-tooltip-multiple-truncated-respondents"
    in
    ( dataAttribute
    , Translations.truncatedRespondents
        language
        idsToDisplay
        (String.fromInt numTruncated)
        others
    )
