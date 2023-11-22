module SurveyResultList.View exposing (view)

import Html.Styled exposing (Html, div, h1, main_, section, text)
import Html.Styled.Attributes exposing (attribute, class, css)
import Language exposing (Language)
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Model exposing (SurveyResultList)
import SurveyResultList.Styles as Styles
import Translations


view : Language -> SurveyResultList -> Html msg
view language { surveyResults } =
    main_ []
        [ section
            [ attribute "data-name" "survey-results"
            , class Styles.section
            ]
            (surveyResultList language surveyResults)
        ]



-- PRIVATE


surveyResultList : Language -> List SurveyResult -> List (Html msg)
surveyResultList language surveyResults =
    let
        surveyResults_ =
            List.map (SurveyResult.summaryView language) surveyResults
    in
    div [ class Styles.surveyResultList ]
        [ heading language ]
        :: surveyResults_


heading : Language -> Html msg
heading language =
    h1
        [ class Styles.heading
        , css [ Styles.headingCss ]
        ]
        [ text (Translations.surveyResults language) ]
