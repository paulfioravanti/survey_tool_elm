module SurveyResponse.Tooltip exposing (view)

{-| Creates content for a tooltip on a survey response from a histogram
of respondent IDs and their responses.
-}

import Dict exposing (Dict)
import Html.Styled exposing (Html, span, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import I18Next exposing (Delims(Curly), Translations)
import Styles
import SurveyResponse.Model exposing (Rating, RespondentId)
import SurveyResponse.RespondentHistogram exposing (RespondentHistogram)


view : Translations -> Rating -> RespondentHistogram -> Html msg
view translations rating histogram =
    let
        ( attributeName, respondents ) =
            histogram
                |> respondentsByResponseContent translations rating

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
    Translations
    -> Rating
    -> RespondentHistogram
    -> ( String, String )
respondentsByResponseContent translations rating histogram =
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
            , I18Next.t translations "noRespondents"
            )
        else if List.length respondents == 1 then
            ( attributeName ++ "one-respondent"
            , (displaySingleRespondent translations respondents)
            )
        else if head == respondents then
            ( attributeName ++ "all-respondents"
            , (displayAllRespondents translations head)
            )
        else
            truncatedRespondents translations head tail


displaySingleRespondent : Translations -> List RespondentId -> String
displaySingleRespondent translations respondents =
    let
        id =
            respondents
                |> List.head
                |> Maybe.withDefault 0
                |> toString
    in
        I18Next.tr translations Curly "oneRespondent" [ ( "id", id ) ]


displayAllRespondents : Translations -> List RespondentId -> String
displayAllRespondents translations respondents =
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
        I18Next.tr translations
            Curly
            "allRespondents"
            [ ( "headIds", headIds ), ( "tailId", tailId ) ]


truncatedRespondents :
    Translations
    -> List RespondentId
    -> List RespondentId
    -> ( String, String )
truncatedRespondents translations respondentsToDisplay truncatedRespondents =
    let
        idsToDisplay =
            respondentsToDisplay
                |> List.map toString
                |> String.join ", "

        numTruncated =
            List.length truncatedRespondents

        others =
            if numTruncated == 1 then
                I18Next.t translations "other"
            else
                I18Next.t translations "others"

        attribute =
            if numTruncated == 1 then
                "survey-response-tooltip-one-truncated-respondent"
            else
                "survey-response-tooltip-multiple-truncated-respondents"
    in
        ( attribute
        , I18Next.tr translations
            Curly
            "truncatedRespondents"
            [ ( "idsToDisplay", idsToDisplay )
            , ( "numTruncated", toString numTruncated )
            , ( "other", others )
            ]
        )
