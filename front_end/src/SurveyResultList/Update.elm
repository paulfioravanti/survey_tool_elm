module SurveyResultList.Update exposing (update)

import Language exposing (Language)
import RemoteData exposing (WebData)
import SurveyResultList.Data as Data
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Msg as Msg exposing (Msg)


update : Language -> Msg -> ( WebData SurveyResultList, String, Cmd Msg )
update language msg =
    case msg of
        Msg.Load apiUrl webData ->
            let
                ( surveyResultList, cmd ) =
                    webData
                        |> Data.load apiUrl

                title =
                    surveyResultList
                        |> Data.title language
            in
            ( surveyResultList, title, cmd )

        Msg.Fetched surveyResultList ->
            let
                title =
                    surveyResultList
                        |> Data.title language
            in
            ( surveyResultList, title, Cmd.none )
