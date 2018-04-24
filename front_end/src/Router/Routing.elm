module Router.Routing exposing (route)

import Html.Styled as Html exposing (Html)
import Message.NotFound as NotFound
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            , NotFoundRoute
            )
        )
import Router.Config exposing (Config)
import Router.Context exposing (Context)
import Router.Utils as Utils
import SurveyResultDetail
import SurveyResultList exposing (SurveyResultList)


route : Config msg -> Context -> Html msg
route config { locale, location, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                surveyResultListConfig =
                    { changeLanguageMsg = config.changeLanguageMsg
                    , surveyResultDetailMsg =
                        (config.changeLocationMsg << SurveyResultDetailRoute)
                    }

                surveyResultListContext =
                    { locale = locale
                    , location = location
                    }
            in
                SurveyResultList.view
                    surveyResultListConfig
                    surveyResultListContext
                    surveyResultList

        SurveyResultDetailRoute id ->
            let
                surveyResultDetailConfig =
                    { backToHomeMsg =
                        config.changeLocationMsg ListSurveyResultsRoute
                    , blurMsg = config.blurMsg (SurveyResultDetailRoute id)
                    , changeLanguageMsg = config.changeLanguageMsg
                    , path = Utils.toPath ListSurveyResultsRoute
                    }

                surveyResultDetailContext =
                    { locale = locale
                    , location = location
                    }
            in
                SurveyResultDetail.view
                    surveyResultDetailConfig
                    surveyResultDetailContext
                    surveyResultDetail

        NotFoundRoute ->
            let
                messageConfig =
                    { backToHomeMsg =
                        config.changeLocationMsg ListSurveyResultsRoute
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                NotFound.view messageConfig locale.translations
