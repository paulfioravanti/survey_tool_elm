module SurveyResultDetail.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Fuzzer.Locale as Locale
import Fuzzer.Navigation.Location as Location
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error(BadStatus, NetworkError))
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultDetailMsg))
import Navigation exposing (Location)
import RemoteData
    exposing
        ( RemoteData
            ( Failure
            , NotRequested
            , Requesting
            , Success
            )
        )
import Result exposing (Result)
import Route exposing (Route(SurveyResultDetail))
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils as Utils
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))
import Test exposing (Test, describe, fuzz4, fuzz5)
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

        surveyResult =
            SurveyResult.fuzzer
    in
        describe "update"
            [ fetchSurveyResultNetworkErrorFailureTest
                config
                locale
                location
                surveyResult
            , fetchSurveyResultBadStatusFailureTest
                config
                locale
                location
                surveyResult
            , fetchSurveyResultBadStatusNotFoundFailureTest
                config
                locale
                location
                surveyResult
            , fetchSurveyResultSuccessTest
                config
                locale
                location
                surveyResult
            ]


fetchSurveyResultNetworkErrorFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultNetworkErrorFailureTest config locale location surveyResult =
    describe
        """
        when SurveyResultDetailMsg FetchSurveyResultDetail request
        fails on a NetworkError
        """
        [ fuzz4
            config
            locale
            location
            surveyResult
            "model surveyResultDetail is updated with a Failure"
            (\config locale location surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            locale
                            location
                            (SurveyResultDetail id)
                            Requesting
                            NotRequested

                    msg =
                        SurveyResultDetailMsg
                            (FetchSurveyResultDetail (Err NetworkError))
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model
                                | surveyResultDetail = Failure NetworkError
                            }
            )
        ]


fetchSurveyResultBadStatusFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusFailureTest config locale location surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus Error
            """
            [ fuzz5
                config
                locale
                location
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
                (\config locale location surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
                                locale
                                location
                                (SurveyResultDetail id)
                                Requesting
                                NotRequested

                        serverErrorResponse =
                            { response
                                | status =
                                    { code = 500
                                    , message = "Internal Server Error"
                                    }
                            }

                        msg =
                            SurveyResultDetailMsg
                                (FetchSurveyResultDetail
                                    (Err (BadStatus serverErrorResponse))
                                )
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model
                                    | surveyResultDetail =
                                        Failure (BadStatus serverErrorResponse)
                                }
                )
            ]


fetchSurveyResultBadStatusNotFoundFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusNotFoundFailureTest config locale location surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus NotFound Error
            """
            [ fuzz5
                config
                locale
                location
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
                (\config locale location surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
                                locale
                                location
                                (SurveyResultDetail id)
                                Requesting
                                NotRequested

                        serverErrorResponse =
                            { response
                                | status =
                                    { code = 404
                                    , message = "Not Found"
                                    }
                            }

                        msg =
                            SurveyResultDetailMsg
                                (FetchSurveyResultDetail
                                    (Err (BadStatus serverErrorResponse))
                                )
                    in
                        model
                            |> Update.update msg
                            |> Tuple.first
                            |> Expect.equal
                                { model
                                    | surveyResultDetail =
                                        Failure (BadStatus serverErrorResponse)
                                }
                )
            ]


fetchSurveyResultSuccessTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer Location
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultSuccessTest config locale location surveyResult =
    describe
        "when SurveyResultDetailMsg FetchSurveyResultDetail request succeeds"
        [ fuzz4
            config
            locale
            location
            surveyResult
            "model surveyResultDetail is updated with a Success"
            (\config locale location surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            locale
                            location
                            (SurveyResultDetail id)
                            NotRequested
                            Requesting

                    msg =
                        SurveyResultDetailMsg
                            (FetchSurveyResultDetail (Ok surveyResultDetail))
                in
                    model
                        |> Update.update msg
                        |> Tuple.first
                        |> Expect.equal
                            { model
                                | surveyResultDetail =
                                    Success surveyResultDetail
                            }
            )
        ]
