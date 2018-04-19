module SurveyResultList.ViewTest exposing (suite)

import Expect
import Fuzzer.Config as Config
import Fuzzer.SurveyResultList as SurveyResultList
import Html.Attributes as Attributes
import Html.Styled
import I18Next exposing (Translations)
import Model exposing (Model)
import RemoteData exposing (RemoteData(NotRequested, Success))
import Route exposing (Route(ListSurveyResultsRoute))
import Router
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

        surveyResults =
            Selector.attribute
                (Attributes.attribute "data-name" "survey-results")
    in
        describe "view"
            [ fuzz2
                config
                surveyResultList
                "displays a list of survey results"
                (\config surveyResultList ->
                    let
                        model =
                            Model
                                config
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                                I18Next.initialTranslations
                    in
                        model
                            |> Router.route
                            |> Html.Styled.toUnstyled
                            |> Query.fromHtml
                            |> Query.has [ tag "section", surveyResults ]
                )
            ]
