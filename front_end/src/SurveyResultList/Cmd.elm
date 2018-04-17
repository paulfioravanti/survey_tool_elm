module SurveyResultList.Cmd exposing (fetchSurveyResultList)

import Http
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    let
        url =
            apiUrl ++ "/survey_results"
    in
        Decoder.decoder
            |> Http.get url
            |> Http.send FetchSurveyResultList
