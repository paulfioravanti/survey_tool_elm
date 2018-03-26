module SurveyResultList.Commands exposing (fetchSurveyResultList)

import Commands exposing (surveyResultsApiUrl)
import SurveyResultList.Decoder as Decoder
import SurveyResultList.Messages exposing (Msg(FetchSurveyResultList))
import Http


fetchSurveyResultList : Cmd Msg
fetchSurveyResultList =
    Decoder.decoder
        |> Http.get surveyResultsApiUrl
        |> Http.send FetchSurveyResultList
