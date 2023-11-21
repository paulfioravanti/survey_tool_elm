module Update.SurveyResult.LoadMsgTest exposing (all)

import Expect
import Fuzz exposing (Fuzzer)
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
    describe "Update.update with Msg.SurveyResult Load"
        [ loadWhenRemoteDataIsNotAskedTest
            randomLanguage
            randomId
        , loadWhenRemoteDataIsLoadingTest
            randomLanguage
            randomId
        , loadWhenRemoteDataIsSuccessWithCurrentSurveyResultTest
            randomLanguage
            randomId
        , loadWhenRemoteDataIsSuccessWithDifferentSurveyResultTest
            randomLanguage
            randomId
        , loadWhenRemoteDataIsFailureTest
            randomLanguage
            randomId
        ]


loadWhenRemoteDataIsNotAskedTest : Fuzzer Language -> Fuzzer Int -> Test
loadWhenRemoteDataIsNotAskedTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"
    in
    describe "when msg contains Msg.Load with NotAsked web data"
        [ fuzz2
            randomLanguage
            randomId
            """
            updates the model's surveyResultDetail with Loading,
            and the model's title with the Loading title
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
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle =
                        Translations.loading language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultDetail to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]


loadWhenRemoteDataIsLoadingTest : Fuzzer Language -> Fuzzer Int -> Test
loadWhenRemoteDataIsLoadingTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"
    in
    describe "when msg contains Msg.Load with Loading web data"
        [ fuzz2
            randomLanguage
            randomId
            """
            leaves the model's surveyResultDetail as Loading,
            and the model's title with the Loading title
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
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle =
                        Translations.loading language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultDetail to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]


loadWhenRemoteDataIsSuccessWithCurrentSurveyResultTest :
    Fuzzer Language
    -> Fuzzer Int
    -> Test
loadWhenRemoteDataIsSuccessWithCurrentSurveyResultTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResult =
            SurveyResult.fuzzer
    in
    describe
        """
        when msg contains Msg.Load with Success with the same id as the
        current survey result detail
        """
        [ fuzz3
            randomLanguage
            randomId
            randomSurveyResult
            """
            the surveyResultDetail in the model and the title stay the same
            """
            (\language intId surveyResult ->
                let
                    id =
                        String.fromInt intId

                    surveyResultWithSameId =
                        { surveyResult | url = "/survey_results/" ++ id }

                    route =
                        Route.SurveyResultDetail id

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail =
                            RemoteData.Success surveyResultWithSameId
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Success surveyResultWithSameId

                    expectedTitle =
                        surveyResultWithSameId.name

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the surveyResultDetail in the model and the
                        title to stay the same
                        """
            )
        ]


loadWhenRemoteDataIsSuccessWithDifferentSurveyResultTest :
    Fuzzer Language
    -> Fuzzer Int
    -> Test
loadWhenRemoteDataIsSuccessWithDifferentSurveyResultTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResult =
            SurveyResult.fuzzer

        expectedSurveyResultDetail =
            RemoteData.Loading
    in
    describe
        """
        when msg contains Msg.Load with Success with a different id as the
        current survey result detail
        """
        [ fuzz3
            randomLanguage
            randomId
            randomSurveyResult
            """
            updates the surveyResultDetail in the model to Loading and updated
            the title to the Loading title
            """
            (\language intId surveyResult ->
                let
                    id =
                        String.fromInt intId

                    surveyResultWithGivenId =
                        { surveyResult
                            | url = "/survey_results/" ++ id
                        }

                    differentId =
                        String.fromInt (intId + 1)

                    route =
                        Route.SurveyResultDetail id

                    model =
                        { apiUrl = apiUrl
                        , language = language
                        , languageSelector = LanguageSelector.init language
                        , navigation = Navigation.init Nothing (Just route)
                        , surveyResultDetail =
                            RemoteData.Success surveyResultWithGivenId
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                differentId
                                model.surveyResultDetail
                            )

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    expectedTitle =
                        Translations.loading language

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the surveyResultDetail in the model to be
                        updated to Loading and the title to be updated to the
                        Loading title
                        """
            )
        ]


loadWhenRemoteDataIsFailureTest : Fuzzer Language -> Fuzzer Int -> Test
loadWhenRemoteDataIsFailureTest randomLanguage randomId =
    let
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomHttpError =
            Error.fuzzer
    in
    describe "when msg contains Msg.Load with Failure web data"
        [ fuzz3
            randomLanguage
            randomId
            randomHttpError
            """
            updates the model's surveyResultDetail with Loading,
            and the model's title with the Loading title
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
                        , surveyResultDetail = RemoteData.Failure httpError
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle =
                        Translations.loading language

                    updatedModel =
                        Update.update msg model
                            |> Tuple.first

                    actualSurveyResultDetail =
                        updatedModel.surveyResultDetail

                    actualTitle =
                        updatedModel.title
                in
                ((expectedSurveyResultDetail == actualSurveyResultDetail)
                    && (expectedTitle == actualTitle)
                )
                    |> Expect.equal True
                    |> Expect.onFail
                        """
                        Expected the model's surveyResultDetail to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]
