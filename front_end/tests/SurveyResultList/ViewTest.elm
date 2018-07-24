module SurveyResultList.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Html.Styled
import Locale exposing (Locale)
import Main
import Model exposing (Model)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(ListSurveyResults))
import Test exposing (Test, describe, fuzz4)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (tag)


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer

        surveyResultList =
            SurveyResultList.fuzzer

        surveyResults =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-results")
    in
        describe "view"
            [ fuzz4
                config
                locale
                location
                surveyResultList
                "displays a list of survey results"
                (\config locale location surveyResultList ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResults
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Main.view
                            |> Query.fromHtml
                            |> Query.has [ tag "section", surveyResults ]
                )
            ]
