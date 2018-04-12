module SurveyResultDetail.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResult as SurveyResult
import Html.Attributes as Attributes
import Html.Styled
import Model exposing (Model)
import Question.Model exposing (Question)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Router
import Routing.Route exposing (Route(SurveyResultDetailRoute))
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils
import Test exposing (Test, describe, fuzz, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
import Theme.Model exposing (Theme)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        surveyResult =
            SurveyResult.detailFuzzer
    in
        describe "view"
            [ fuzz
                config
                "displays a survey result detail page"
              <|
                \config ->
                    let
                        surveyResult =
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

                        id =
                            surveyResult.url
                                |> SurveyResult.Utils.extractId

                        model =
                            Model
                                config
                                (SurveyResultDetailRoute id)
                                (Success surveyResult)
                                NotRequested

                        surveyResultDetail =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "survey-result-detail"
                                )
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "article", surveyResultDetail ]
            ]
