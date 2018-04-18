module SurveyResultDetail.Cmd exposing (fetchSurveyResult)

{-| Commands for detailed survey results.
-}

import Http
import SurveyResultDetail.Decoder as Decoder
import SurveyResultDetail.Msg exposing (Msg(FetchSurveyResultDetail))


fetchSurveyResult : String -> String -> Cmd Msg
fetchSurveyResult id apiUrl =
    let
        url =
            apiUrl ++ id
    in
        Decoder.decoder
            |> Http.get url
            |> Http.send FetchSurveyResultDetail
