module SurveyResult.Cmd exposing (fetchSurveyResult)

{-| Commands for survey results.
-}

import Http
import SurveyResultDetail.Decoder as Decoder
import SurveyResult.Msg exposing (Msg(FetchSurveyResult))


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    let
        url =
            apiUrl ++ "/survey_results/" ++ id
    in
        Decoder.decoder
            |> Http.get url
            |> Http.send FetchSurveyResult
