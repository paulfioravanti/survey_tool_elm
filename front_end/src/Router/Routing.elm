module Router.Routing exposing (route)

import Html.Styled as Html exposing (Html)
import Locale exposing (Locale)
import Message.NotFound as NotFound
import RemoteData exposing (WebData)
import Route
    exposing
        ( Route
            ( ListSurveyResultsRoute
            , SurveyResultDetailRoute
            , NotFoundRoute
            )
        )
import Router.Model exposing (Config)
import Router.Msg exposing (Msg(Blur, ChangeLocation))
import Router.Utils as Utils
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail
import SurveyResultList exposing (SurveyResultList)


route : Config -> Html Msg
route { locale, route, surveyResultList, surveyResultDetail } =
    case route of
        ListSurveyResultsRoute ->
            let
                config =
                    { surveyResultDetailMsg =
                        (ChangeLocation << SurveyResultDetailRoute)
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
