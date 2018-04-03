module SurveyResultList.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Model exposing (Model)
import RemoteData exposing (RemoteData(Success))
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)
import View


suite : Test
suite =
    let
        config =
            Config.fuzzer

        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe "view"
            [ fuzz2
                config
                surveyResultList
                "displays an error message when page cannot be found"
              <|
                \config surveyResultList ->
                    let
                        model =
                            Model
                                (Success surveyResultList)
                                config
                                ListSurveyResultsRoute

                        surveyResults =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "survey-results"
                                )
                    in
                        model
                            |> View.view
                            |> Query.fromHtml
                            |> Query.find [ tag "section" ]
                            |> Query.has [ surveyResults ]
            ]
