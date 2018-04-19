module SurveyResultDetail.UpdateTest exposing (suite)

import Config exposing (Config)
import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Config as Config
import Fuzzer.Http.Response as Response
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error(BadStatus, NetworkError))
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
import Test exposing (Test, describe, fuzz2, fuzz3)
import Update


suite : Test
suite =
    let
        config =
            Config.fuzzer

        surveyResult =
            SurveyResult.fuzzer
    in
        describe "update"
            [ fetchSurveyResultNetworkErrorFailureTest config surveyResult
            , fetchSurveyResultBadStatusFailureTest config surveyResult
            , fetchSurveyResultBadStatusNotFoundFailureTest config surveyResult
            , fetchSurveyResultSuccessTest config surveyResult
            ]


fetchSurveyResultNetworkErrorFailureTest :
    Fuzzer Config
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultNetworkErrorFailureTest config surveyResult =
    describe
        """
        when SurveyResultDetailMsg FetchSurveyResultDetail request
        fails on a NetworkError
        """
        [ fuzz2
            config
            surveyResult
            "model surveyResultDetail is updated with a Failure"
          <|
            \config surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
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
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusFailureTest config surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus Error
            """
            [ fuzz3
                config
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
              <|
                \config surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
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
    -> Fuzzer SurveyResult
    -> Test
fetchSurveyResultBadStatusNotFoundFailureTest config surveyResult =
    let
        response =
            Response.fuzzer
    in
        describe
            """
            when SurveyResultDetailMsg FetchSurveyResultDetail request
            fails on a BadStatus NotFound Error
            """
            [ fuzz3
                config
                surveyResult
                response
                "model surveyResultDetail is updated with a Failure"
              <|
                \config surveyResultDetail response ->
                    let
                        id =
                            surveyResultDetail.url
                                |> Utils.extractId

                        model =
                            Model
                                config
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


fetchSurveyResultSuccessTest : Fuzzer Config -> Fuzzer SurveyResult -> Test
fetchSurveyResultSuccessTest config surveyResult =
    describe
        "when SurveyResultDetailMsg FetchSurveyResultDetail request succeeds"
        [ fuzz2
            config
            surveyResult
            "model surveyResultDetail is updated with a Success"
            (\config surveyResultDetail ->
                let
                    id =
                        surveyResultDetail.url
                            |> Utils.extractId

                    model =
                        Model
                            config
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
