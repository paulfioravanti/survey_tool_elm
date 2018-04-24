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
import Router.Context exposing (Context)
import Router.Msg exposing (Msg(Blur, ChangeLanguage, ChangeLocation))
import Router.Utils as Utils
import SurveyResultDetail
import SurveyResultList exposing (SurveyResultList)


route : Context -> Html Msg
route { locale, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                surveyResultListConfig =
                    { changeLanguageMsg = ChangeLanguage route
                    , surveyResultDetailMsg =
                        (ChangeLocation << SurveyResultDetailRoute)
                    }
            in
                SurveyResultList.view
                    surveyResultListConfig
                    locale.translations
                    surveyResultList

        SurveyResultDetailRoute id ->
            let
                surveyResultDetailConfig =
                    { backToHomeMsg = ChangeLocation ListSurveyResultsRoute
                    , blurMsg = Blur (SurveyResultDetailRoute id)
                    , changeLanguageMsg = ChangeLanguage route
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                SurveyResultDetail.view
                    surveyResultDetailConfig
                    locale.translations
                    surveyResultDetail

        NotFoundRoute ->
            let
                messageConfig =
                    { backToHomeMsg = ChangeLocation ListSurveyResultsRoute
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                NotFound.view messageConfig locale.translations
