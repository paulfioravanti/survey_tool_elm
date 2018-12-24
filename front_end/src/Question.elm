module Question exposing
    ( Question
    , decoder
    , sumValidResponses
    , view
    )

import Html.Styled exposing (Html)
import Json.Decode exposing (Decoder)
import Language exposing (Language)
import Question.Aggregation as Aggregation
import Question.Decoder as Decoder
import Question.Model as Model
import Question.View as View


type alias Question =
    Model.Question


decoder : Decoder Question
decoder =
    Decoder.decoder


sumValidResponses : Question -> Int
sumValidResponses question =
    Aggregation.sumValidResponses question


view : Language -> Question -> Html msg
view language question =
    View.view language question
