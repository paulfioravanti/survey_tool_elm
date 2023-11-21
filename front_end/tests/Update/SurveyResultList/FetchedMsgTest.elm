module Update.SurveyResultList.FetchedMsgTest exposing (all)

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
import SurveyResultList.Fuzzer as SurveyResultList
import SurveyResultList.Msg
import Test exposing (Test, describe, fuzz, fuzz2)
import Title
import Translations
import Update


all : Test
all =
    let
        randomLanguage =
            Language.fuzzer
    in
    describe "Update.update with Msg.SurveyResultList Fetched"
        [ fetchedWhenRemoteDataIsSuccessTest randomLanguage
        , fetchedWhenRemoteDataIsNotFoundTest randomLanguage
        , fetchedWhenRemoteDataIsFailureTest randomLanguage
        ]


fetchedWhenRemoteDataIsSuccessTest : Fuzzer Language -> Test
fetchedWhenRemoteDataIsSuccessTest randomLanguage =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResultList =
            SurveyResultList.fuzzer
    in
    describe "when msg contains Msg.Fetched with Success data"
        [ fuzz2
            randomLanguage
            randomSurveyResultList
            """
            the surveyResultList in the model is updated to the Success data
            and the model title is changed to the survey results title
            """
            (\language surveyResultList ->
                let
                    route =
                        Route.SurveyResultList

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Loading
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Fetched
                                (RemoteData.Success surveyResultList)
                            )

                    expectedSurveyResultList =
                        RemoteData.Success surveyResultList

                    expectedTitle =
                        Translations.surveyResults language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the surveyResultList in the model to be the
                        Success survey result List data and the title to be the
                        survey results title
                        """
            )
        ]


fetchedWhenRemoteDataIsNotFoundTest : Fuzzer Language -> Test
fetchedWhenRemoteDataIsNotFoundTest randomLanguage =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        httpError =
            Http.BadStatus 404
    in
    describe "when msg contains Msg.Fetched with not found web data"
        [ fuzz
            randomLanguage
            """
            updates the model's surveyResultList with the Failure data,
            and the model's title with the Not Found title
            """
            (\language ->
                let
                    route =
                        Route.SurveyResultList

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Loading
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultList =
                        RemoteData.Failure httpError

                    expectedTitle =
                        Translations.notFound language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultList to be Failure
                        data, and the model's title to be the not found title
                        """
            )
        ]


fetchedWhenRemoteDataIsFailureTest : Fuzzer Language -> Test
fetchedWhenRemoteDataIsFailureTest randomLanguage =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomHttpError =
            Error.fuzzer
    in
    describe "when msg contains Msg.Fetched with Failure web data"
        [ fuzz2
            randomLanguage
            randomHttpError
            """
            updates the model's surveyResultList with the Failure data,
            and the model's title with the error retrieving data title
            """
            (\language httpError ->
                let
                    route =
                        Route.SurveyResultList

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Loading
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Fetched
                                (RemoteData.Failure httpError)
                            )

                    expectedSurveyResultList =
                        RemoteData.Failure httpError

                    expectedTitle =
                        Translations.errorRetrievingData language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultList to be Failure
                        data, and the model's title to be the error retrieving
                        data title
                        """
            )
        ]
