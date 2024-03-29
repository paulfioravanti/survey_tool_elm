module Update.SurveyResult.FetchedMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Fuzzer.Error as Error
import Fuzzer.Language as Language
import Fuzzer.SurveyResult as SurveyResult
import Http exposing (Error)
import Language exposing (Language)
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation
import RemoteData exposing (WebData)
import Route exposing (Route)
import SurveyResult exposing (SurveyResult)
import SurveyResult.Msg
import Test exposing (Test, describe, fuzz2, fuzz3)
import Title
import Translations
import Update


all : Test
all =
    let
        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer

        randomId : Fuzzer Int
        randomId =
            Fuzz.int
    in
    describe "Update.update with Msg.SurveyResult Fetched"
        [ fetchedWhenRemoteDataIsSuccessTest randomLanguage randomId
        , fetchedWhenRemoteDataIsNotFoundTest randomLanguage randomId
        , fetchedWhenRemoteDataIsFailureTest randomLanguage randomId
        ]


fetchedWhenRemoteDataIsSuccessTest : Fuzzer Language -> Fuzzer Int -> Test
fetchedWhenRemoteDataIsSuccessTest randomLanguage randomId =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResult : Fuzzer SurveyResult
        randomSurveyResult =
            SurveyResult.fuzzer
    in
    describe "when msg contains Msg.Fetched with Success data"
        [ fuzz3
            randomLanguage
            randomId
            randomSurveyResult
            """
            the surveyResultDetail in the model is updated to the Success data
            and the model title is changed to the fetched survey result's name
            """
            (\language intId surveyResult ->
                let
                    id : String
                    id =
                        String.fromInt intId

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Success surveyResult)
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Success surveyResult

                    expectedTitle : String
                    expectedTitle =
                        surveyResult.name

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultDetail : WebData SurveyResult
                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the surveyResultDetail in the model to be the
                        Success survey result data and the title to be the survey
                        result name
                        """
            )
        ]


fetchedWhenRemoteDataIsNotFoundTest : Fuzzer Language -> Fuzzer Int -> Test
fetchedWhenRemoteDataIsNotFoundTest randomLanguage randomId =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        httpError : Error
        httpError =
            Http.BadStatus 404
    in
    describe "when msg contains Msg.Fetched with not found web data"
        [ fuzz2
            randomLanguage
            randomId
            """
            updates the model's surveyResultDetail with the Failure data,
            and the model's title with the Not Found title
            """
            (\language intId ->
                let
                    id : String
                    id =
                        String.fromInt intId

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Failure httpError

                    expectedTitle : String
                    expectedTitle =
                        Translations.notFound language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultDetail : WebData SurveyResult
                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultDetail to be Failure
                        data, and the model's title to be the not found title
                        """
            )
        ]


fetchedWhenRemoteDataIsFailureTest : Fuzzer Language -> Fuzzer Int -> Test
fetchedWhenRemoteDataIsFailureTest randomLanguage randomId =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomHttpError : Fuzzer Error
        randomHttpError =
            Error.fuzzer
    in
    describe "when msg contains Msg.Fetched with Failure web data"
        [ fuzz3
            randomLanguage
            randomId
            randomHttpError
            """
            updates the model's surveyResultDetail with the Failure data,
            and the model's title with the error retrieving data title
            """
            (\language intId httpError ->
                let
                    id : String
                    id =
                        String.fromInt intId

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Failure httpError

                    expectedTitle : String
                    expectedTitle =
                        Translations.errorRetrievingData language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultDetail : WebData SurveyResult
                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultDetail to be Failure
                        data, and the model's title to be the error retrieving
                        data title
                        """
            )
        ]
