port module Window exposing (updateErrorTitle, updateRouteTitle, updateTitle)

import Http exposing (Error(BadStatus))
import Route exposing (Route(ListSurveyResultsRoute))
import Translations exposing (Lang)


port updateTitle : String -> Cmd msg


updateErrorTitle : Error -> Lang -> Cmd msg
updateErrorTitle error language =
    let
        title =
            case error of
                BadStatus response ->
                    case response.status.code of
                        404 ->
                            Translations.notFound language

                        _ ->
                            Translations.errorRetrievingData language

                _ ->
                    Translations.errorRetrievingData language
    in
        updateTitle title


updateRouteTitle : Route -> Lang -> Cmd msg
updateRouteTitle route language =
    case route of
        ListSurveyResultsRoute ->
            updateTitle (Translations.surveyResults language)

        _ ->
            Cmd.none
