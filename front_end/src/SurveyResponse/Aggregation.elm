module SurveyResponse.Aggregation exposing (countValidResponse, ratingScore)

import SurveyResponse.Model exposing (SurveyResponse)


{-| Given an integer accumulator, adds 1 to it if the `responseContent` value
in a `SurveyResponse` is a value between 1-5. Otherwise, the accumulator is
returned unchanged.

    import SurveyResponse.Model exposing (SurveyResponse)

    emptySurveyResponse : SurveyResponse
    emptySurveyResponse =
        SurveyResponse 1 1 1 ""

    countValidResponse emptySurveyResponse 0
    --> 0

    validSurveyResponse : SurveyResponse
    validSurveyResponse =
        { emptySurveyResponse | responseContent = "4" }

    countValidResponse validSurveyResponse 0
    --> 1

    negativeValueSurveyResponse : SurveyResponse
    negativeValueSurveyResponse =
        { emptySurveyResponse | responseContent = "-1" }

    countValidResponse negativeValueSurveyResponse 0
    --> 0

    zeroValueSurveyResponse : SurveyResponse
    zeroValueSurveyResponse =
        { emptySurveyResponse | responseContent = "0" }

    countValidResponse zeroValueSurveyResponse 0
    --> 0

    overMaxValueSurveyResponse : SurveyResponse
    overMaxValueSurveyResponse =
        { emptySurveyResponse | responseContent = "6" }

    countValidResponse overMaxValueSurveyResponse 0
    --> 0

    nonNumberValueSurveyResponse : SurveyResponse
    nonNumberValueSurveyResponse =
        { emptySurveyResponse | responseContent = "invalid" }

    countValidResponse nonNumberValueSurveyResponse 0
    --> 0

-}
countValidResponse : SurveyResponse -> Int -> Int
countValidResponse surveyResponse acc =
    let
        score =
            ratingScore surveyResponse
    in
    if isValidScore score then
        acc + 1

    else
        acc


{-| Returns the `responseContent` value in a `SurveyResponse` as an integer.
If the `responseContent` value is not a value between 1-5, a rating of 0 is
returned.

    import SurveyResponse.Model exposing (SurveyResponse)

    emptySurveyResponse : SurveyResponse
    emptySurveyResponse =
        SurveyResponse 1 1 1 ""

    ratingScore emptySurveyResponse
    --> 0

    validSurveyResponse : SurveyResponse
    validSurveyResponse =
        { emptySurveyResponse | responseContent = "4" }

    ratingScore validSurveyResponse
    --> 4

    negativeValueSurveyResponse : SurveyResponse
    negativeValueSurveyResponse =
        { emptySurveyResponse | responseContent = "-1" }

    ratingScore negativeValueSurveyResponse
    --> 0

    zeroValueSurveyResponse : SurveyResponse
    zeroValueSurveyResponse =
        { emptySurveyResponse | responseContent = "0" }

    ratingScore zeroValueSurveyResponse
    --> 0

    overMaxValueSurveyResponse : SurveyResponse
    overMaxValueSurveyResponse =
        { emptySurveyResponse | responseContent = "6" }

    ratingScore overMaxValueSurveyResponse
    --> 0

    nonNumberValueSurveyResponse : SurveyResponse
    nonNumberValueSurveyResponse =
        { emptySurveyResponse | responseContent = "invalid" }

    ratingScore nonNumberValueSurveyResponse
    --> 0

-}
ratingScore : SurveyResponse -> Int
ratingScore { responseContent } =
    let
        score =
            responseContent
                |> String.toInt
                |> Maybe.withDefault 0
    in
    if isValidScore score then
        score

    else
        0



-- PRIVATE


isValidScore : Int -> Bool
isValidScore score =
    score > 0 && score < 6
