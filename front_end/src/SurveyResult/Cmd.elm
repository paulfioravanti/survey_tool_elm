module SurveyResult.Cmd exposing (fetchSurveyResult)

{-| Commands for survey results.
-}

import Http
import SurveyResultDetail
import SurveyResult.Msg exposing (Msg(FetchSurveyResult))


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    let
        url =
            apiUrl ++ id
    in
        SurveyResultDetail.decoder
            |> Http.get url
            |> Http.send FetchSurveyResult
