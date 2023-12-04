module Update.SurveyResultList.LoadMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
import Http exposing (Error)
import Http.Error.Fuzzer as Error
import Language exposing (Language)
import Language.Fuzzer as Language
import LanguageSelector
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation
import RemoteData exposing (WebData)
import Route exposing (Route)
import SurveyResultList exposing (SurveyResultList)
import SurveyResultList.Fuzzer as SurveyResultList
import SurveyResultList.Msg
import Test exposing (Test, describe, fuzz, fuzz2)
import Title
import Translations
import Update


all : Test
all =
    let
        randomLanguage : Fuzzer Language
        randomLanguage =
            Language.fuzzer
    in
    describe "Update.update with Msg.SurveyResultList Load"
        [ loadWhenRemoteDataIsNotAskedTest randomLanguage
        , loadWhenRemoteDataIsLoadingTest randomLanguage
        , loadWhenRemoteDataIsSuccess randomLanguage
        , loadWhenRemoteDataIsFailureTest randomLanguage
        ]


loadWhenRemoteDataIsNotAskedTest : Fuzzer Language -> Test
loadWhenRemoteDataIsNotAskedTest randomLanguage =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"
    in
    describe "when msg contains Msg.Load with NotAsked web data"
        [ fuzz
            randomLanguage
            """
            updates the model's surveyResultList with Loading,
            and the model's title with the Loading title
            """
            (\language ->
                let
                    route : Route
                    route =
                        Route.SurveyResultList

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Load
                                apiUrl
                                model.surveyResultList
                            )

                    expectedSurveyResultList : WebData SurveyResultList
                    expectedSurveyResultList =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultList : WebData SurveyResultList
                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultList to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]


loadWhenRemoteDataIsLoadingTest : Fuzzer Language -> Test
loadWhenRemoteDataIsLoadingTest randomLanguage =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"
    in
    describe "when msg contains Msg.Load with Loading web data"
        [ fuzz
            randomLanguage
            """
            leaves the model's surveyResultList as Loading,
            and the model's title with the Loading title
            """
            (\language ->
                let
                    route : Route
                    route =
                        Route.SurveyResultList

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Loading
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Load
                                apiUrl
                                model.surveyResultList
                            )

                    expectedSurveyResultList : WebData SurveyResultList
                    expectedSurveyResultList =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultList : WebData SurveyResultList
                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultList to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]


loadWhenRemoteDataIsSuccess : Fuzzer Language -> Test
loadWhenRemoteDataIsSuccess randomLanguage =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResultList : Fuzzer SurveyResultList
        randomSurveyResultList =
            SurveyResultList.fuzzer
    in
    describe "when msg contains Msg.Load with Success data"
        [ fuzz2
            randomLanguage
            randomSurveyResultList
            """
            the surveyResultList in the model and the title stay the same
            """
            (\language surveyResultList ->
                let
                    route : Route
                    route =
                        Route.SurveyResultList

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Success surveyResultList
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Load
                                apiUrl
                                model.surveyResultList
                            )

                    expectedSurveyResultList : WebData SurveyResultList
                    expectedSurveyResultList =
                        RemoteData.Success surveyResultList

                    expectedTitle : String
                    expectedTitle =
                        Translations.surveyResults language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultList : WebData SurveyResultList
                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the surveyResultList in the model and the
                        title to stay the same
                        """
            )
        ]


loadWhenRemoteDataIsFailureTest : Fuzzer Language -> Test
loadWhenRemoteDataIsFailureTest randomLanguage =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomHttpError : Fuzzer Error
        randomHttpError =
            Error.fuzzer
    in
    describe "when msg contains Msg.Load with Failure web data"
        [ fuzz2
            randomLanguage
            randomHttpError
            """
            updates the model's surveyResultList with Loading,
            and the model's title with the Loading title
            """
            (\language httpError ->
                let
                    route : Route
                    route =
                        Route.SurveyResultList

                    model : Model
                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.Failure httpError
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResultList
                            (SurveyResultList.Msg.Load
                                apiUrl
                                model.surveyResultList
                            )

                    expectedSurveyResultList : WebData SurveyResultList
                    expectedSurveyResultList =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    actualSurveyResultList : WebData SurveyResultList
                    actualSurveyResultList =
                        updatedModel.surveyResultList

                    actualTitle : String
                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultList == actualSurveyResultList)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultList to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]
