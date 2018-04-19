port module Window exposing (updateErrorTitle, updateRouteTitle, updateTitle)

import Http
import Route exposing (Route(ListSurveyResultsRoute))


port updateTitle : String -> Cmd msg


updateErrorTitle : Http.Error -> Cmd msg
updateErrorTitle error =
    let
        title =
            case error of
                Http.BadStatus response ->
                    case response.status.code of
                        404 ->
                            "Not Found"

                        _ ->
                            "Error Retrieving Data"

                _ ->
                    "Error Retrieving Data"
    in
        updateTitle title


updateRouteTitle : Route -> Cmd msg
updateRouteTitle route =
    case route of
        ListSurveyResultsRoute ->
            updateTitle "Survey Results"

        _ ->
            Cmd.none
