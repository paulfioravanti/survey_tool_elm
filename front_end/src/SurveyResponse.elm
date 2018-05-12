module SurveyResponse
    exposing
        ( RespondentHistogram
        , SurveyResponse
        , addValidResponse
        , averageScore
        , decoder
        , respondentHistogram
        , sumResponseContent
        , view
        )

import Html.Styled exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import SurveyResponse.Decoder as Decoder
import SurveyResponse.Model as Model
import SurveyResponse.RespondentHistogram as RespondentHistogram
import SurveyResponse.Utils as Utils
import SurveyResponse.View as View
import Translations exposing (Lang)


type alias SurveyResponse =
    Model.SurveyResponse


type alias Rating =
    Model.Rating


type alias RespondentHistogram =
    RespondentHistogram.RespondentHistogram


addValidResponse : SurveyResponse -> Int -> Int
addValidResponse surveyResponse acc =
    Utils.addValidResponse surveyResponse acc


averageScore : List SurveyResponse -> String
averageScore surveyResponses =
    Utils.averageScore surveyResponses


decoder : Decoder SurveyResponse
decoder =
    Decoder.decoder


respondentHistogram : List SurveyResponse -> RespondentHistogram
respondentHistogram surveyResponses =
    RespondentHistogram.init surveyResponses


sumResponseContent : List SurveyResponse -> Int
sumResponseContent surveyResponses =
    Utils.sumResponseContent surveyResponses


view : msg -> Lang -> RespondentHistogram -> Rating -> Html msg
view blurMsg language respondents rating =
    View.view blurMsg language respondents rating
