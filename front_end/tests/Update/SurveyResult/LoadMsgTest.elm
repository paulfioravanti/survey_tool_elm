module Update.SurveyResult.LoadMsgTest exposing (all)

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
        apiUrl : String
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
                        , surveyResultDetail = RemoteData.NotAsked
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

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
                        Expected the model's surveyResultDetail to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]


loadWhenRemoteDataIsLoadingTest : Fuzzer Language -> Fuzzer Int -> Test
loadWhenRemoteDataIsLoadingTest randomLanguage randomId =
    let
        apiUrl : String
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
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

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
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResult : Fuzzer SurveyResult
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
                    id : String
                    id =
                        String.fromInt intId

                    surveyResultWithSameId : SurveyResult
                    surveyResultWithSameId =
                        { surveyResult | url = "/survey_results/" ++ id }

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    model : Model
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

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Success surveyResultWithSameId

                    expectedTitle : String
                    expectedTitle =
                        surveyResultWithSameId.name

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
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomSurveyResult : Fuzzer SurveyResult
        randomSurveyResult =
            SurveyResult.fuzzer

        expectedSurveyResultDetail : WebData SurveyResult
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
                    id : String
                    id =
                        String.fromInt intId

                    surveyResultWithGivenId : SurveyResult
                    surveyResultWithGivenId =
                        { surveyResult
                            | url = "/survey_results/" ++ id
                        }

                    differentId : String
                    differentId =
                        String.fromInt (intId + 1)

                    route : Route
                    route =
                        Route.SurveyResultDetail id

                    model : Model
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

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                differentId
                                model.surveyResultDetail
                            )

                    updatedModel : Model
                    updatedModel =
                        Tuple.first (Update.update msg model)

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

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
                        Expected the surveyResultDetail in the model to be
                        updated to Loading and the title to be updated to the
                        Loading title
                        """
            )
        ]


loadWhenRemoteDataIsFailureTest : Fuzzer Language -> Fuzzer Int -> Test
loadWhenRemoteDataIsFailureTest randomLanguage randomId =
    let
        apiUrl : String
        apiUrl =
            "https://www.example.com/api/endpoint"

        randomHttpError : Fuzzer Error
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
                        , surveyResultDetail = RemoteData.Failure httpError
                        , surveyResultList = RemoteData.NotAsked
                        , title = Title.init (Just route) language
                        }

                    msg : Msg
                    msg =
                        Msg.SurveyResult
                            (SurveyResult.Msg.Load
                                apiUrl
                                id
                                model.surveyResultDetail
                            )

                    expectedSurveyResultDetail : WebData SurveyResult
                    expectedSurveyResultDetail =
                        RemoteData.Loading

                    expectedTitle : String
                    expectedTitle =
                        Translations.loading language

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
                        Expected the model's surveyResultDetail to be Loading,
                        and the model's title to be the Loading title
                        """
            )
        ]
