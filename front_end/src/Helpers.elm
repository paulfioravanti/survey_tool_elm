module Helpers
    exposing
        ( extractSurveyResultDetailId
        , toFormattedPercentage
        , toSurveyResultDetailUrl
        )

import Regex exposing (HowMany(AtMost))


extractSurveyResultDetailId : String -> String
extractSurveyResultDetailId url =
    url
        |> Regex.find (AtMost 1) (Regex.regex "/([^/]+).json$")
        |> List.concatMap .submatches
        |> List.head
        |> Maybe.withDefault (Just "")
        |> Maybe.withDefault ""


toFormattedPercentage : Float -> String
toFormattedPercentage float =
    let
        percent =
            float
                * 100
                |> round
                |> toString
    in
        percent ++ "%"


{-| Removes ".json" from a string.

    -- You can write the expected result on the next line,

    toSurveyResultDetailUrl "/survey_results/1.json"
    --> "/survey_results/1"

    toSurveyResultDetailUrl "/survey_results/1"
    --> "/survey_results/1"
-}
toSurveyResultDetailUrl : String -> String
toSurveyResultDetailUrl url =
    url
        |> String.split ".json"
        |> String.join ""
