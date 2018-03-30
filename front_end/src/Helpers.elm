module Helpers
    exposing
        ( extractSurveyResultDetailId
        , toFormattedPercentage
        , toSurveyResultDetailUrl
        )

import Regex exposing (HowMany(AtMost))


{-|
This function goes on the assumption that survey result detail IDs are integers.
Returning integer 0 is potentially not the best way to resolve "bad"
survey result detail IDs provided by the server, but it will at least
cause a NotFound error, which should be adequate for error handling.
-}
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


toSurveyResultDetailUrl : String -> String
toSurveyResultDetailUrl url =
    url
        |> String.split ".json"
        |> String.join ""
