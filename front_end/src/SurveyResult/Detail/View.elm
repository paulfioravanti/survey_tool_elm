module SurveyResult.Detail.View exposing (view)

import Html.Styled
    exposing
        ( Html
        , a
        , article
        , div
        , footer
        , h1
        , i
        , img
        , main_
        , text
        )
import Html.Styled.Attributes exposing (alt, attribute, class, css, href, src)
import Language exposing (Language)
import Route
import SurveyResult.Detail.Overview.View as Overview
import SurveyResult.Detail.Styles as Styles
import SurveyResult.Model exposing (SurveyResult)
import Theme exposing (Theme)


view : Language -> SurveyResult -> Html msg
view language surveyResult =
    main_ []
        [ article
            [ attribute "data-name" "survey-result-detail"
            , class Styles.article
            ]
            [ surveyResultsLink
            , surveyName surveyResult.name
            , Overview.view language surveyResult
            , surveyResultThemes language surveyResult.themes
            , footerContent
            ]
        ]



-- PRIVATE


surveyResultsLink : Html msg
surveyResultsLink =
    a
        [ href (Route.toString Route.SurveyResultList)
        , class Styles.surveyResultsLink
        ]
        [ i
            [ class Styles.surveyResultsLinkIcon
            , css [ Styles.brandColor ]
            ]
            []
        ]


surveyName : String -> Html msg
surveyName name =
    div [ class Styles.surveyName ]
        [ h1 [ class Styles.surveyNameHeading ]
            [ text name ]
        ]


surveyResultThemes : Language -> Maybe (List Theme) -> Html msg
surveyResultThemes language maybeThemes =
    let
        themes : List Theme
        themes =
            Maybe.withDefault [] maybeThemes
    in
    div [ attribute "data-name" "themes" ]
        (List.map (Theme.view language) themes)


footerContent : Html msg
footerContent =
    footer [ class Styles.footerContent ]
        [ a
            [ href (Route.toString Route.SurveyResultList)
            , class Styles.footerLink
            ]
            [ img
                [ src "/logo.png"
                , class Styles.footerLogo
                , alt "logo"
                ]
                []
            ]
        ]
