module SurveyResponse exposing
    ( RespondentHistogram
    , SurveyResponse
    , countValidResponse
    , decoder
    , ratingScore
    , ratings
    , respondentHistogram
    , view
    )

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Language exposing (Language)
import SurveyResponse.Aggregation as Aggregation
import SurveyResponse.Decoder as Decoder
import SurveyResponse.Model as Model
import SurveyResponse.Ratings as Ratings
import SurveyResponse.RespondentHistogram as RespondentHistogram
import SurveyResponse.View as View


type alias SurveyResponse =
    Model.SurveyResponse


type alias RespondentHistogram =
    RespondentHistogram.RespondentHistogram


countValidResponse : SurveyResponse -> Int -> Int
countValidResponse surveyResponse acc =
    Aggregation.countValidResponse surveyResponse acc


decoder : Decoder SurveyResponse
decoder =
    Decoder.decoder


ratings : List String
ratings =
    Ratings.init


ratingScore : SurveyResponse -> Int
ratingScore surveyResponse =
    Aggregation.ratingScore surveyResponse


respondentHistogram : List SurveyResponse -> RespondentHistogram
respondentHistogram surveyResponses =
    RespondentHistogram.init surveyResponses


view : Language -> RespondentHistogram -> String -> Html msg
view language respondents rating =
    View.view language respondents rating
