module SurveyResult.Parser exposing (id)

{-| Parser to extract a survey result ID from a `SurveyResult`'s `url` string.
-}

import Parser exposing ((|.), (|=), Parser)
import SurveyResult.Model exposing (SurveyResult)


{-|

    import SurveyResult.Model exposing (SurveyResult)

    surveyResult : SurveyResult
    surveyResult =
        SurveyResult "Simple Survey" 6 0.83 5 Nothing ""

    numberIdWithFileExtension : SurveyResult
    numberIdWithFileExtension =
      { surveyResult | url = "/survey_results/10.json" }

    id numberIdWithFileExtension
    --> "10"

    numberIdWithoutFileExtension : SurveyResult
    numberIdWithoutFileExtension =
      { surveyResult | url = "/survey_results/10" }

    id numberIdWithoutFileExtension
    --> "10"

    stringIdWithFileExtension : SurveyResult
    stringIdWithFileExtension =
      { surveyResult | url = "/survey_results/abc.json" }

    id stringIdWithFileExtension
    --> "abc"

    stringIdWithoutFileExtension : SurveyResult
    stringIdWithoutFileExtension =
      { surveyResult | url = "/survey_results/abc" }

    id stringIdWithoutFileExtension
    --> "abc"

    surveyResultWithInvalidUrl : SurveyResult
    surveyResultWithInvalidUrl =
      { surveyResult | url = "invalid" }

    id surveyResultWithInvalidUrl
    ---> ""

-}
id : SurveyResult -> String
id surveyResult =
    let
        idParser : Parser String
        idParser =
            Parser.succeed identity
                |. Parser.symbol "/"
                |. Parser.chompUntil "/"
                |. Parser.symbol "/"
                |= Parser.getChompedString (Parser.chompUntilEndOr ".")
    in
    surveyResult.url
        |> Parser.run idParser
        |> Result.withDefault ""
