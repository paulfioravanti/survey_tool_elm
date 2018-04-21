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
import Router.Msg exposing (Msg(Blur, ChangeLocation))
import Router.Utils as Utils
import SurveyResult exposing (SurveyResult)
import SurveyResultDetail
import SurveyResultList exposing (SurveyResultList)


route :
    Locale
    -> Route
    -> WebData SurveyResultList
    -> WebData SurveyResult
    -> Html Msg
route locale route surveyResultList surveyResultDetail =
    case route of
        ListSurveyResultsRoute ->
            let
                msg =
                    (ChangeLocation << SurveyResultDetailRoute)
            in
                SurveyResultList.view msg locale.translations surveyResultList

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
                msg =
                    (ChangeLocation ListSurveyResultsRoute)

                path =
                    Utils.toPath ListSurveyResultsRoute
            in
                NotFound.view msg path locale.translations
