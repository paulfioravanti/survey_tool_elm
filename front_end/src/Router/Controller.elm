module Router.Controller exposing (route)

import Html.Styled exposing (Html)
import Message.NotFound as NotFound
import Route exposing (Route(ListSurveyResults, SurveyResultDetail, NotFound))
import Router.Config exposing (Config)
import Router.Context exposing (Context)
import Router.Msg exposing (Msg(ChangeLocation))
import Router.Utils as Utils
import SurveyResultDetail
import SurveyResultList


route : Config msg -> Context -> Html msg
route config { locale, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResults ->
            let
                surveyResultListConfig =
                    { localeMsg = config.localeMsg
                    , blurMsg = config.blurMsg
                    , surveyResultDetailMsg =
                        config.routingMsg
                            << ChangeLocation
                            << SurveyResultDetail
                    }
            in
                SurveyResultList.view
                    surveyResultListConfig
                    locale
                    surveyResultList

        -- suppressed parameter is `id`
        SurveyResultDetail _ ->
            let
                surveyResultDetailConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResults)
                    , backToHomePath = Utils.toPath ListSurveyResults
                    , blurMsg = config.blurMsg
                    , localeMsg = config.localeMsg
                    }
            in
                SurveyResultDetail.view
                    surveyResultDetailConfig
                    locale
                    surveyResultDetail

        NotFound ->
            let
                messageConfig =
                    { backToHomeMsg =
                        config.routingMsg
                            (ChangeLocation ListSurveyResults)
                    , backToHomePath =
                        ListSurveyResults
                            |> Utils.toPath
                    }
            in
                NotFound.view messageConfig locale.language
