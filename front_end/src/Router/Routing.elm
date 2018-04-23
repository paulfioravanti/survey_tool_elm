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
                config =
                    { surveyResultDetailMsg =
                        (ChangeLocation << SurveyResultDetailRoute)
                    , changeLanguageMsg = ChangeLanguage route
                    }
            in
                SurveyResultList.view
                    config
                    locale.translations
                    surveyResultList

        SurveyResultDetailRoute id ->
            let
                config =
                    { backToHomeMsg = ChangeLocation ListSurveyResultsRoute
                    , blurMsg = Blur (SurveyResultDetailRoute id)
                    , changeLanguageMsg = ChangeLanguage route
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                SurveyResultDetail.view
                    config
                    locale.translations
                    surveyResultDetail

        NotFoundRoute ->
            let
                config =
                    { backToHomeMsg = ChangeLocation ListSurveyResultsRoute
                    , path = Utils.toPath ListSurveyResultsRoute
                    }
            in
                NotFound.view config locale.translations
