module SurveyResponse.Styles exposing
    ( surveyResponse
    , surveyResponseContent
    , surveyResponseContentCss
    , surveyResponseCss
    )

{-| SurveyResponse styling using CSS and Tachyons.
-}

import Css exposing (Style, hover, visibility, visible)
import Css.Global as Global
import Styles


surveyResponseContent : String
surveyResponseContent =
    String.join " "
        [ "b--light-silver"
        , "ba"
        , "bg-moon-gray"
        , "br4"
        , "dtc"
        , "h2"
        , "hover-white"
        , "pointer"
        , "relative"
        , "tc"
        , "v-mid"
        , "w2"
        ]


surveyResponseContentCss : Style
surveyResponseContentCss =
    hover
        [ Styles.brandBorderColor
        , Global.children
            [ Global.selector
                "[data-name*='survey-response-tooltip']"
                [ visibility visible ]
            ]
        ]


surveyResponse : String
surveyResponse =
    String.join " "
        [ "dt"
        , "mh1"
        , "no-underline"
        ]


surveyResponseCss : Style
surveyResponseCss =
    hover
        [ Global.children
            [ Global.selector
                "[data-name='survey-response-content']"
                [ Styles.brandBackgroundColor ]
            ]
        ]
