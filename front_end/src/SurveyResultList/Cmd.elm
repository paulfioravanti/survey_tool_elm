module SurveyResultList.Cmd exposing (fetchSurveyResultList)

import Http
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Msg exposing (Msg(FetchSurveyResultList))


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    Decoder.decoder
        |> Http.get apiUrl
        |> Http.send FetchSurveyResultList
