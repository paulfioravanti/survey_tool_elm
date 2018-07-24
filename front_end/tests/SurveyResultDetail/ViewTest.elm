module SurveyResultDetail.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Main
import Model exposing (Model)
import Navigation exposing (Location)
import Question.Model exposing (Question)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(SurveyResultDetail))
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Test exposing (Test, describe, fuzz3)
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

        location =
            Location.fuzzer

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
            [ fuzz3
                config
                locale
                location
                "displays a survey result detail page"
                (\config locale location ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                (SurveyResultDetail id)
                                (Success surveyResult)
                                NotRequested
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.has [ tag "article", surveyResultDetail ]
                )
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
