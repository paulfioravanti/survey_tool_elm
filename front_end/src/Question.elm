module Question exposing (Question, averageScore, decoder, view)

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Question.Decoder as Decoder
import Question.Model as Model
import Question.Utils as Utils
import Question.View as View
import Translations exposing (Lang)


type alias Question =
    Model.Question


averageScore : List Question -> String
averageScore questions =
    Utils.averageScore questions


decoder : Decoder Question
decoder =
    Decoder.decoder


view : msg -> Lang -> Question -> Html msg
view blurMsg language { description, surveyResponses } =
    View.view blurMsg language description surveyResponses
