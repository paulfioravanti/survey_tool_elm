module UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Locale exposing (Locale)
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
import Test exposing (Test, describe, fuzz2)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        msg =
            UpdatePage ()
    in
        describe "update when UpdatePage msg sent"
            [ surveyResultsListNotRequestedTest config locale msg
            , surveyResultsListAlreadyRequestedTest config locale msg
            , surveyResultDetailNotRequestedTest config locale msg
            , routeNotFoundTest config locale msg
            ]


surveyResultsListNotRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Msg
    -> Test
surveyResultsListNotRequestedTest config locale msg =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList is NotRequested
        """
        [ fuzz2
            config
            locale
            "it updates the surveyResultsList to Requesting"
          <|
            \config locale ->
                let
                    model =
                        Model
                            config
                            locale
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


surveyResultsListAlreadyRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Msg
    -> Test
surveyResultsListAlreadyRequestedTest config locale msg =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList already requested ie not NotRequested.
        """
        [ fuzz2 config locale "it does not update the model" <|
            \config locale ->
                let
                    model =
                        Model
                            config
                            locale
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal model
        ]


surveyResultDetailNotRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Msg
    -> Test
surveyResultDetailNotRequestedTest config locale msg =
    describe
        """
        when UpdatePage SurveyResultDetailRoute msg sent and
        surveyResultsDetail is NotRequested
        """
        [ fuzz2
            config
            locale
            "it updates the surveyResultDetail to Requesting"
            (\config locale ->
                let
                    model =
                        Model
                            config
                            locale
                            (SurveyResultDetailRoute "10")
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model | surveyResultDetail = Requesting }
            )
        ]


routeNotFoundTest : Fuzzer Config -> Fuzzer Locale -> Msg -> Test
routeNotFoundTest config locale msg =
    describe "when route is unknown"
        [ fuzz2 config locale "it does not update the model." <|
            \config locale ->
                let
                    model =
                        Model
                            config
                            locale
                            NotFoundRoute
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal model
        ]
