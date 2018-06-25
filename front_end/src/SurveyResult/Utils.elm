module SurveyResult.Utils exposing (extractId, toDetailUrl)

{-| Utility functions for a survey result.
-}

import Regex exposing (HowMany(AtMost), Regex)


{-| Extracts the survey result detail ID from a given URL

    extractId "/survey_results/10.json"
    --> "10"

    extractId "/survey_results/10"
    --> "10"

    extractId "/survey_results/abc.json"
    --> "abc"

    extractId "/survey_results/abc"
    --> "abc"

-}
extractId : String -> String
extractId url =
    url
        |> Regex.find (AtMost 1) surveyResultUrlRegex
        |> List.concatMap .submatches
        |> List.head
        |> Maybe.withDefault (Just "")
        |> Maybe.withDefault ""


{-| Removes ".json" from a string.

    toDetailUrl "/survey_results/1.json"
    --> "/survey_results/1"

    toDetailUrl "/survey_results/1"
    --> "/survey_results/1"

-}
toDetailUrl : String -> String
toDetailUrl url =
    url
        |> String.split ".json"
        |> String.join ""


surveyResultUrlRegex : Regex
surveyResultUrlRegex =
    Regex.regex "/([^/.]+)(?:.json)?$"
