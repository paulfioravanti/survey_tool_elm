module Update.SurveyResult.FetchedMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Http
import Http.Error.Fuzzer as Error
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import LanguageSelector.Msg
import Msg
import Navigation
import RemoteData
import Route exposing (Route)
import Route.Fuzzer as Route
import SurveyResult.Fuzzer as SurveyResult
import SurveyResult.Msg
import Test exposing (Test, describe, fuzz2, fuzz3)
import Title
import Translations
import Update


all : Test
all =
    let
        randomLanguage =
            Language.fuzzer

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
        apiUrl =
            "https://www.example.com/api/endpoint"

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
                    id =
                        String.fromInt intId

                    route =
                        Route.SurveyResultDetail id

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Success surveyResult)
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Success surveyResult

                    expectedTitle =
                        surveyResult.name

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                Expect.true
                    """
                    Expected the surveyResultDetail in the model to be the
                    Success survey result data and the title to be the survey
                    result name
                    """
                    ((expectedSurveyResultDetail == actualSurveyResultDetail)
                        && (expectedTitle == actualTitle)
                    )
            )
        ]


fetchedWhenRemoteDataIsNotFoundTest : Fuzzer Language -> Fuzzer Int -> Test
fetchedWhenRemoteDataIsNotFoundTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

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
                    id =
                        String.fromInt intId

                    route =
                        Route.SurveyResultDetail id

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Failure httpError

                    expectedTitle =
                        Translations.notFound language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                Expect.true
                    """
                    Expected the model's surveyResultDetail to be Failure data,
                    and the model's title to be the not found title
                    """
                    ((expectedSurveyResultDetail == actualSurveyResultDetail)
                        && (expectedTitle == actualTitle)
                    )
            )
        ]


fetchedWhenRemoteDataIsFailureTest : Fuzzer Language -> Fuzzer Int -> Test
fetchedWhenRemoteDataIsFailureTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

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
                    id =
                        String.fromInt intId

                    route =
                        Route.SurveyResultDetail id

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.Loading
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Failure httpError

                    expectedTitle =
                        Translations.errorRetrievingData language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                Expect.true
                    """
                    Expected the model's surveyResultDetail to be Failure data,
                    and the model's title to be the error retrieving data title
                    """
                    ((expectedSurveyResultDetail == actualSurveyResultDetail)
                        && (expectedTitle == actualTitle)
                    )
            )
        ]
