module Helpers
    exposing
        ( errorToMessage
        , extractSurveyResultDetailId
        , toFormattedPercentage
        , toSurveyResultDetailUrl
        )

import Http
import Regex exposing (HowMany(AtMost))


{-| Returns a tagged message tuple from a Http.Error

    import Dict
    import Http

    type alias Status =
        { code : Int, message : String }

    response : body -> Http.Response body
    response body =
        Http.Response
            "www.example.com"
            (Status 400 "Not Found")
            Dict.empty
            body


    errorToMessage Http.NetworkError
    --> ( "network-error-message", "Is the server running?" )

    errorToMessage (Http.BadStatus (response "Response body"))
    --> ( "bad-status-message", "\"Not Found\"" )

    errorToMessage (Http.BadPayload "Payload Failed" (response "Response body"))
    --> ( "bad-payload-message", "Decoding Failed: Payload Failed")

    errorToMessage (Http.Timeout)
    --> ( "other-error-message", "Timeout" )

-}
errorToMessage : Http.Error -> ( String, String )
errorToMessage error =
    case error of
        Http.NetworkError ->
            ( "network-error-message", "Is the server running?" )

        Http.BadStatus response ->
            ( "bad-status-message", toString response.status.message )

        Http.BadPayload message response ->
            ( "bad-payload-message", "Decoding Failed: " ++ message )

        _ ->
            ( "other-error-message", toString error )


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
