module Question exposing (Question, averageScore, decoder, view)

import Html.Styled exposing (Html)
import I18Next exposing (Translations)
import Json.Decode as Decode exposing (Decoder)
import Question.Decoder as Decoder
import Question.Model as Model
import Question.Utils as Utils
import Question.View as View
import SurveyResultDetail.Config exposing (Config)


type alias Question =
    Model.Question


averageScore : List Question -> String
averageScore questions =
    Utils.averageScore questions


decoder : Decoder Question
decoder =
    Decoder.decoder


view : Config msg -> Translations -> Question -> Html msg
view config translations { description, surveyResponses } =
    View.view config translations description surveyResponses
