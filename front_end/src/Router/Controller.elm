module Router.Controller exposing (route)

import Html.Styled exposing (Html)
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
import SurveyResultList


route : Config msg -> Context -> Html msg
route config { locale, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                surveyResultListConfig =
                    { localeMsg = config.localeMsg
                    , blurMsg = config.blurMsg
                    , surveyResultDetailMsg =
                        config.routingMsg
                            << ChangeLocation
                            << SurveyResultDetailRoute
                    }
            in
                SurveyResultList.view
                    surveyResultListConfig
                    locale
                    surveyResultList

        -- suppressed parameter is `id`
        SurveyResultDetailRoute _ ->
            let
                surveyResultDetailConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResultsRoute)
                    , backToHomePath = Utils.toPath ListSurveyResultsRoute
                    , blurMsg = config.blurMsg
                    , localeMsg = config.localeMsg
                    }
            in
                SurveyResultDetail.view
                    surveyResultDetailConfig
                    locale
                    surveyResultDetail

        NotFoundRoute ->
            let
                messageConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResultsRoute)
                    , backToHomePath =
                        ListSurveyResultsRoute
                            |> Utils.toPath
                    }
            in
                NotFound.view messageConfig locale.language
