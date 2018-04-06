module Helpers
    exposing
        ( extractSurveyResultDetailId
        , toFormattedPercentage
        , toSurveyResultDetailUrl
        )

import Regex exposing (HowMany(AtMost))


{-| Extracts the survey result detail ID from a given URL

    extractSurveyResultDetailId "/survey_results/10.json"
    --> "10"

    extractSurveyResultDetailId "/survey_results/10"
    --> "10"

    extractSurveyResultDetailId "/survey_results/abc.json"
    --> "abc"

    extractSurveyResultDetailId "/survey_results/abc"
    --> "abc"

-}
extractSurveyResultDetailId : String -> String
extractSurveyResultDetailId url =
    url
        |> Regex.find (AtMost 1) (Regex.regex "/([^/.]+)(?:.json)?$")
        |> List.concatMap .submatches
        |> List.head
        |> Maybe.withDefault (Just "")
        |> Maybe.withDefault ""


{-| Formats a float into a displayable percentage

    toFormattedPercentage 0.8333333333333334
    --> "83%"

    toFormattedPercentage 0.8366666666666664
    --> "84%"

-}
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
