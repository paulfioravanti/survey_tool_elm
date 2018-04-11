module SurveyResultList.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Html.Styled
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Router
import Routing.Route exposing (Route(ListSurveyResultsRoute))
import Test exposing (Test, describe, fuzz2)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


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
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)

                        surveyResults =
                            Selector.attribute
                                (Attributes.attribute
                                    "data-name"
                                    "survey-results"
                                )
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "section", surveyResults ]
            ]
