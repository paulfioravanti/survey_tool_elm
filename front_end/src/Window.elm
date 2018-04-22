port module Window exposing (updateErrorTitle, updateRouteTitle, updateTitle)

import Http exposing (Error(BadStatus))
import I18Next exposing (Translations)
import Route exposing (Route(ListSurveyResultsRoute))


port updateTitle : String -> Cmd msg


updateErrorTitle : Error -> Translations -> Cmd msg
updateErrorTitle error translations =
    let
        title =
            case error of
                BadStatus response ->
                    case response.status.code of
                        404 ->
                            I18Next.t translations "notFound"

                        _ ->
                            I18Next.t translations "errorRetrievingData"

                _ ->
                    I18Next.t translations "errorRetrievingData"
    in
        updateTitle title


updateRouteTitle : Route -> Translations -> Cmd msg
updateRouteTitle route translations =
    case route of
        ListSurveyResultsRoute ->
            updateTitle (I18Next.t translations "surveyResults")

        _ ->
            Cmd.none
