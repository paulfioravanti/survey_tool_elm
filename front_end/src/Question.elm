module Question exposing (Question, averageScore, decoder, view)

import Html.Styled exposing (Html)
import Json.Decode as Decode
import Question.Decoder as Decoder
import Question.Model as Model
import Question.Utils as Utils
import Question.View as View


type alias Question =
    Model.Question


averageScore : List Question -> String
averageScore questions =
    Utils.averageScore questions


decoder : Decode.Decoder Question
decoder =
    Decoder.decoder


view : Question -> Html msg
view { description, surveyResponses } =
    View.view description surveyResponses
