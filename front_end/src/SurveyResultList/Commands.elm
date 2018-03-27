module SurveyResultList.Commands exposing (fetchSurveyResultList)

import SurveyResultList.Decoder as Decoder
import SurveyResultList.Messages exposing (Msg(FetchSurveyResultList))
import Http


fetchSurveyResultList : String -> Cmd Msg
fetchSurveyResultList apiUrl =
    Decoder.decoder
        |> Http.get apiUrl
        |> Http.send FetchSurveyResultList
