module UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Model exposing (Model)
import Msg exposing (Msg(UpdatePage))
import RemoteData exposing (RemoteData(NotRequested, Requesting))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        msg =
            UpdatePage ()
    in
        describe "update when UpdatePage msg sent"
            [ surveyResultsListNotRequestedTest config msg
            , surveyResultsListAlreadyRequestedTest config msg
            , surveyResultDetailNotRequestedTest config msg
            , routeNotFoundTest config msg
            ]


surveyResultsListNotRequestedTest : Fuzzer Config -> Msg -> Test
surveyResultsListNotRequestedTest config msg =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList is NotRequested
        """
        [ fuzz
            config
            "it updates the surveyResultsList to Requesting"
          <|
            \config ->
                let
                    model =
                        Model
                            config
                            ListSurveyResultsRoute
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model | surveyResultList = Requesting }
        ]


surveyResultsListAlreadyRequestedTest : Fuzzer Config -> Msg -> Test
surveyResultsListAlreadyRequestedTest config msg =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList already requested ie not NotRequested.
        """
        [ fuzz config "it does not update the model" <|
            \config ->
                let
                    model =
                        Model
                            config
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal model
        ]


surveyResultDetailNotRequestedTest : Fuzzer Config -> Msg -> Test
surveyResultDetailNotRequestedTest config msg =
    describe
        """
        when UpdatePage SurveyResultDetailRoute msg sent and
        surveyResultsDetail is NotRequested
        """
        [ fuzz config "it updates the surveyResultDetail to Requesting" <|
            \config ->
                let
                    model =
                        Model
                            config
                            (SurveyResultDetailRoute "10")
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model | surveyResultDetail = Requesting }
        ]


routeNotFoundTest : Fuzzer Config -> Msg -> Test
routeNotFoundTest config msg =
    describe "when route is unknown"
        [ fuzz config "it does not update the model." <|
            \config ->
                let
                    model =
                        Model
                            config
                            NotFoundRoute
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal model
        ]
