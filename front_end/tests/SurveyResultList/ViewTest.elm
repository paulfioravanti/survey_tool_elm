module SurveyResultList.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(ListSurveyResultsRoute))
import Router
import Test exposing (Test, describe, fuzz3)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        surveyResultList =
            SurveyResultList.fuzzer

        surveyResults =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-results")
    in
        describe "view"
            [ fuzz3
                config
                locale
                surveyResultList
                "displays a list of survey results"
                (\config locale surveyResultList ->
                    let
                        model =
                            Model
                                config
                                locale
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "section", surveyResults ]
                )
            ]
