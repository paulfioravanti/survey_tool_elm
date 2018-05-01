module UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Fuzzer.SurveyResultList as SurveyResultList
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(Blur, UpdatePage))
import Navigation exposing (Location)
import RemoteData exposing (RemoteData(NotRequested, Requesting, Success))
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , NotFoundRoute
            , SurveyResultDetailRoute
            )
        )
import Test exposing (Test, describe, fuzz3, fuzz4)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        location =
            Location.fuzzer
    in
        describe "update when UpdatePage msg sent"
            [ surveyResultsListNotRequestedTest config locale location
            , surveyResultsListAlreadyRequestedTest config locale location
            , surveyResultsListAlreadyRetrievedTest config locale location
            , surveyResultDetailNotRequestedTest config locale location
            , routeNotFoundTest config locale location
            , blurTest config locale location
            ]


surveyResultsListNotRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
surveyResultsListNotRequestedTest config locale location =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList is NotRequested
        """
        [ fuzz3
            config
            locale
            location
            "it updates the surveyResultsList to Requesting"
          <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            ListSurveyResultsRoute
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update (UpdatePage location)
                        |> Tuple.first
                        |> Expect.equal
                            { model | surveyResultList = Requesting }
        ]


surveyResultsListAlreadyRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
surveyResultsListAlreadyRequestedTest config locale location =
    describe
        """
        when UpdatePage ListSurveyResultsRoute msg sent and
        surveyResultsList already requested ie not NotRequested.
        """
        [ fuzz3 config locale location "it does not update the model" <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting
                in
                    model
                        |> Update.update (UpdatePage location)
                        |> Tuple.first
                        |> Expect.equal model
        ]


surveyResultsListAlreadyRetrievedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
surveyResultsListAlreadyRetrievedTest config locale location =
    let
        surveyResultList =
            SurveyResultList.fuzzer
    in
        describe
            """
            when UpdatePage ListSurveyResultsRoute msg sent and
            surveyResultsList has already been retrieved ie Success
            """
            [ fuzz4
                config
                locale
                location
                surveyResultList
                "it does not update the model"
                (\config locale location surveyResultList ->
                    let
                        model =
                            Model
                                config
                                locale
                                location
                                ListSurveyResultsRoute
                                NotRequested
                                (Success surveyResultList)
                    in
                        model
                            |> Update.update (UpdatePage location)
                            |> Tuple.first
                            |> Expect.equal model
                )
            ]


surveyResultDetailNotRequestedTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
surveyResultDetailNotRequestedTest config locale location =
    describe
        """
        when UpdatePage SurveyResultDetailRoute msg sent and
        surveyResultsDetail is NotRequested
        """
        [ fuzz3
            config
            locale
            location
            "it updates the surveyResultDetail to Requesting"
            (\config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            (SurveyResultDetailRoute "10")
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update (UpdatePage location)
                        |> Tuple.first
                        |> Expect.equal
                            { model | surveyResultDetail = Requesting }
            )
        ]


routeNotFoundTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Test
routeNotFoundTest config locale location =
    describe "when route is unknown"
        [ fuzz3 config locale location "it does not update the model." <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            NotFoundRoute
                            NotRequested
                            NotRequested
                in
                    model
                        |> Update.update (UpdatePage location)
                        |> Tuple.first
                        |> Expect.equal model
        ]


blurTest : Fuzzer Config -> Fuzzer Locale -> Fuzzer Location -> Test
blurTest config locale location =
    -- NOTE: Not sure how to test that a Task has been queued up to be executed
    -- by the Elm runtime, but the LocaleMsg CloseAvailableLanguages msg is
    -- tested in the tests/Locale/UpdateTest.elm file.
    describe "when msg is Blur"
        [ fuzz3 config locale location "model is returned as-is" <|
            \config locale location ->
                let
                    model =
                        Model
                            config
                            locale
                            location
                            ListSurveyResultsRoute
                            NotRequested
                            Requesting
                in
                    model
                        |> Update.update Blur
                        |> Tuple.first
                        |> Expect.equal model
        ]
