module SurveyResultDetail.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Fuzzer.Locale as Locale
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error(BadStatus, NetworkError))
import Locale exposing (Locale)
import Model exposing (Model)
import Msg exposing (Msg(SurveyResultDetailMsg))
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
import Route exposing (Route(SurveyResultDetailRoute))
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Utils as Utils
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))
import Test exposing (Test, describe, fuzz3, fuzz4)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        locale =
            Locale.fuzzer

        surveyResult =
            SurveyResult.fuzzer
    in
        describe "update"
            [ fetchSurveyResultNetworkErrorFailureTest
                config
                locale
                surveyResult
            , fetchSurveyResultBadStatusFailureTest
                config
                locale
                surveyResult
            , fetchSurveyResultBadStatusNotFoundFailureTest
                config
                locale
                surveyResult
            , fetchSurveyResultSuccessTest
                config
                locale
                surveyResult
            ]


fetchSurveyResultNetworkErrorFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultNetworkErrorFailureTest config locale surveyResult =
    describe
        """
        when SurveyResultDetailMsg FetchSurveyResultDetail request
        fails on a NetworkError
        """
        [ fuzz3
            config
            locale
            surveyResult
            "model surveyResultDetail is updated with a Failure"
          <|
            \config locale surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            locale
                            (SurveyResultDetailRoute id)
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
        ]


fetchSurveyResultBadStatusFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusFailureTest config locale surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus Error
            """
            [ fuzz4
                config
                locale
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
              <|
                \config locale surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
                                locale
                                (SurveyResultDetailRoute id)
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
            ]


fetchSurveyResultBadStatusNotFoundFailureTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusNotFoundFailureTest config locale surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus NotFound Error
            """
            [ fuzz4
                config
                locale
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
              <|
                \config locale surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
                                locale
                                (SurveyResultDetailRoute id)
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
            ]


fetchSurveyResultSuccessTest :
    Fuzzer Config
    -> Fuzzer Locale
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultSuccessTest config locale surveyResult =
    describe
        "when SurveyResultDetailMsg FetchSurveyResultDetail request succeeds"
        [ fuzz3
            config
            locale
            surveyResult
            "model surveyResultDetail is updated with a Success"
            (\config locale surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
                            locale
                            (SurveyResultDetailRoute id)
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
