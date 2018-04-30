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
import Router.Msg exposing (Msg(ChangeLocation))
import Router.Utils as Utils
import SurveyResultDetail
import SurveyResultList exposing (SurveyResultList)


route : Config msg -> Context -> Html msg
route config { locale, location, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                surveyResultListConfig =
                    { localeMsg = config.localeMsg
                    , blurMsg = config.blurMsg
                    , surveyResultDetailMsg =
                        (config.routingMsg
                            << ChangeLocation
                            << SurveyResultDetailRoute
                        )
                    }

                surveyResultListContext =
                    { locale = locale }
            in
                SurveyResultList.view
                    surveyResultListConfig
                    surveyResultListContext
                    surveyResultList

        SurveyResultDetailRoute id ->
            let
                surveyResultDetailConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResultsRoute)
                    , blurMsg = config.blurMsg
                    , localeMsg = config.localeMsg
                    , path = Utils.toPath ListSurveyResultsRoute
                    }

                surveyResultDetailContext =
                    { locale = locale }
            in
                SurveyResultDetail.view
                    surveyResultDetailConfig
                    surveyResultDetailContext
                    surveyResultDetail

        NotFoundRoute ->
            let
                messageConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResultsRoute)
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                NotFound.view messageConfig locale.translations
