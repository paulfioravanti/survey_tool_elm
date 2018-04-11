module SurveyResponse.Utils
    exposing
        ( addValidResponse
        , averageScore
        , respondentHistogram
        , sumResponseContent
        )

import Dict exposing (Dict)
import Round
import SurveyResponse.Model exposing (SurveyResponse)


addValidResponse : SurveyResponse -> Int -> Int
addValidResponse surveyResponse acc =
    let
        responseContent =
            surveyResponse.responseContent
                |> toIntValue
    in
        if responseContent > 0 then
            acc + 1
        else
            acc


averageScore : List SurveyResponse -> String
averageScore surveyResponses =
    let
        sum =
            surveyResponses
                |> sumResponseContent
                |> toFloat

        total =
            surveyResponses
                |> countValidResponses
                |> toFloat
    in
        total
            |> (/) sum
            |> Round.round 2


respondentHistogram : List SurveyResponse -> Dict String (List Int)
respondentHistogram surveyResponses =
    let
        histogram =
            Dict.fromList
                [ ( "1", [] )
                , ( "2", [] )
                , ( "3", [] )
                , ( "4", [] )
                , ( "5", [] )
                ]

        prependRatingToList { respondentId, responseContent } histogram =
            if Dict.member responseContent histogram then
                Dict.update
                    responseContent
                    (Maybe.map ((::) respondentId))
                    histogram
            else
                histogram
    in
        List.foldl prependRatingToList histogram surveyResponses


sumResponseContent : List SurveyResponse -> Int
sumResponseContent surveyResponses =
    let
        addResponseContent =
            (\surveyResponse acc ->
                surveyResponse.responseContent
                    |> toIntValue
                    |> (+) acc
            )
    in
        surveyResponses
            |> List.foldl addResponseContent 0


countValidResponses : List SurveyResponse -> Int
countValidResponses surveyResponses =
    surveyResponses
        |> List.foldl addValidResponse 0


toIntValue : String -> Int
toIntValue responseContent =
    responseContent
        |> String.toInt
        |> Result.withDefault 0
