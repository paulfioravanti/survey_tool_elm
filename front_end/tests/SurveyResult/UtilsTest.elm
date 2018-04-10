module SurveyResult.UtilsTest
    exposing
        ( extractIdTests
        , toDetailUrlTests
        )

import Expect
import Fuzz exposing (Fuzzer, float, string)
import Fuzzer.SurveyResultDetailId as SurveyResultDetailId
import Regex
import SurveyResult.Utils as Utils
import Test exposing (Test, describe, fuzz, test)


extractIdTests : Test
extractIdTests =
    let
        surveyResultDetailId =
            SurveyResultDetailId.fuzzer
    in
        describe "extractId"
            [ fuzz surveyResultDetailId "extracts the id from a url string" <|
                \id ->
                    let
                        url =
                            "/survey_results/" ++ id ++ ".json"
                    in
                        url
                            |> Utils.extractId
                            |> Expect.equal id
            ]


toDetailUrlTests : Test
toDetailUrlTests =
    describe "toDetailUrl"
        [ fuzz string "removes .json from any string" <|
            \string ->
                string
                    |> Utils.toDetailUrl
                    |> String.contains ".json"
                    |> not
                    |> Expect.true "Expected to not contain '.json'"
        ]
