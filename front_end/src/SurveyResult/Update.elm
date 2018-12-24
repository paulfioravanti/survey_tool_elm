module SurveyResult.Update exposing (update)

import Language exposing (Language)
import RemoteData exposing (WebData)
import SurveyResult.Data as Data
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Msg as Msg exposing (Msg)


update : Language -> Msg -> ( WebData SurveyResult, String, Cmd Msg )
update language msg =
    case msg of
        Msg.Load apiUrl id webData ->
            let
                ( surveyResult, cmd ) =
                    webData
                        |> Data.load apiUrl id

                title =
                    surveyResult
                        |> Data.title language
            in
            ( surveyResult, title, cmd )

        Msg.Fetched surveyResult ->
            let
                title =
                    surveyResult
                        |> Data.title language
            in
            ( surveyResult, title, Cmd.none )
