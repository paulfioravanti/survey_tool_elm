module SurveyResultDetail.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Model exposing (Model)
import Question.Model exposing (Question)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(SurveyResultDetailRoute))
import Router
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Test exposing (Test, describe, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
import Theme.Model exposing (Theme)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        -- NOTE: Use of this fuzzer in the test would seem to hang the suite,
        -- so only use it if you explicitly set the fuzz count to a low number.
        -- surveyResult =
        --     SurveyResult.detailFuzzer
        surveyResult =
            surveyResultFactory

        id =
            surveyResult.url
                |> SurveyResult.Utils.extractId

        surveyResultDetail =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-result-detail")
    in
        describe "view"
            [ fuzz2 config locale "displays a survey result detail page" <|
                \config locale ->
                    let
                        model =
                            Model
                                config
                                locale
                                (SurveyResultDetailRoute id)
                                (Success surveyResult)
                                NotRequested
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "article", surveyResultDetail ]
            ]


surveyResultFactory : SurveyResult
surveyResultFactory =
    SurveyResult
        "Simple Survey"
        6
        0.8333333333333334
        5
        (Just
            [ Theme
                "The Work"
                [ Question
                    "I like the kind of work I do."
                    [ SurveyResponse 1 1 1 "5" ]
                    "ratingquestion"
                ]
            ]
        )
        "/survey_results/1.json"
