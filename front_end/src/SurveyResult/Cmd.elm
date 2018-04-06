module SurveyResult.Cmd exposing (fetchSurveyResult)

import Http
import SurveyResultDetail.Decoder as Decoder
import SurveyResult.Msg exposing (Msg(FetchSurveyResult))


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    let
        url =
            apiUrl ++ "/" ++ id
    in
        Decoder.decoder
            |> Http.get url
            |> Http.send FetchSurveyResult
