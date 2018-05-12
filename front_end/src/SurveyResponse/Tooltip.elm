module SurveyResponse.Tooltip exposing (view)

{-| Creates content for a tooltip on a survey response from a histogram
of respondent IDs and their responses.
-}

import Dict exposing (Dict)
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Styles
import SurveyResponse.Model exposing (Rating, RespondentId)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)
import Translations exposing (Lang)


view : Lang -> Rating -> RespondentHistogram -> Html msg
view language rating histogram =
    let
        ( attributeName, respondents ) =
            histogram
                |> respondentsByResponseContent language rating

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
                |> class
    in
        span
            [ attribute "data-name" attributeName
            , classes
            , css [ Styles.tooltip ]
            ]
            [ text respondents ]


respondentsByResponseContent :
    Lang
    -> Rating
    -> RespondentHistogram
    -> ( String, String )
respondentsByResponseContent language rating histogram =
    let
        numIdsToDisplay =
            5

        respondents =
            histogram
                |> Dict.get rating
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
            , Translations.noRespondents language
            )
        else if List.length respondents == 1 then
            ( attributeName ++ "one-respondent"
            , (displaySingleRespondent language respondents)
            )
        else if head == respondents then
            ( attributeName ++ "all-respondents"
            , (displayAllRespondents language head)
            )
        else
            truncatedRespondents language head tail


displaySingleRespondent : Lang -> List RespondentId -> String
displaySingleRespondent language respondents =
    let
        id =
            respondents
                |> List.head
                |> Maybe.withDefault 0
                |> toString
    in
        Translations.oneRespondent language id


displayAllRespondents : Lang -> List RespondentId -> String
displayAllRespondents language respondents =
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
        Translations.allRespondents language headIds tailId


truncatedRespondents :
    Lang
    -> List RespondentId
    -> List RespondentId
    -> ( String, String )
truncatedRespondents language respondentsToDisplay truncatedRespondents =
    let
        idsToDisplay =
            respondentsToDisplay
                |> List.map toString
                |> String.join ", "

        numTruncated =
            List.length truncatedRespondents

        others =
            if numTruncated == 1 then
                Translations.other language
            else
                Translations.others language

        attribute =
            if numTruncated == 1 then
                "survey-response-tooltip-one-truncated-respondent"
            else
                "survey-response-tooltip-multiple-truncated-respondents"
    in
        ( attribute
        , Translations.truncatedRespondents
            language
            idsToDisplay
            (toString numTruncated)
            others
        )
