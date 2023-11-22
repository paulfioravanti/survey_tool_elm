module SurveyResult.Summary.View exposing (view)

import Html.Styled exposing (Html, a, article, div, h1, text)
import Html.Styled.Attributes exposing (attribute, class, css, href)
import Language exposing (Language)
import SurveyResult.Model exposing (SurveyResult)
import SurveyResult.Path as Path
import SurveyResult.Summary.Styles as Styles
import Translations
import Utils


view : Language -> SurveyResult -> Html msg
view language surveyResult =
    article
        [ class Styles.summary
        , css [ Styles.summaryCss ]
        ]
        [ summaryLink language surveyResult ]



-- PRIVATE


summaryLink : Language -> SurveyResult -> Html msg
summaryLink language surveyResult =
    a
        [ href (Path.path surveyResult)
        , class Styles.summaryLink
        ]
        [ summaryHeading surveyResult.name
        , summaryContent language surveyResult
        ]


summaryHeading : String -> Html msg
summaryHeading name =
    h1
        [ attribute "data-name" "summary-heading"
        , class Styles.summaryHeading
        ]
        [ text name ]


summaryContent : Language -> SurveyResult -> Html msg
summaryContent language surveyResult =
    div [ class Styles.summaryContent ]
        [ statistics language surveyResult
        , responseRate language surveyResult.responseRate
        ]


statistics : Language -> SurveyResult -> Html msg
statistics language { participantCount, submittedResponseCount } =
    div [ class Styles.statistics ]
        [ statistic (Translations.participants language) participantCount
        , statistic (Translations.responses language) submittedResponseCount
        ]


statistic : String -> Int -> Html msg
statistic label value =
    div [ class Styles.statistic ]
        [ div [ class Styles.statisticLabel ]
            [ text label ]
        , div [ class Styles.statisticValue ]
            [ text (String.fromInt value) ]
        ]


responseRate : Language -> Float -> Html msg
responseRate language responseRate_ =
    let
        responseRatePercentage : String
        responseRatePercentage =
            Utils.percentFromFloat responseRate_
    in
    div [ class Styles.responseRate ]
        [ div [ class Styles.responseRateLabel ]
            [ text (Translations.responseRate language) ]
        , div
            [ attribute "data-name" "response-rate-value"
            , class Styles.responseRateValue
            ]
            [ text responseRatePercentage ]
        ]
