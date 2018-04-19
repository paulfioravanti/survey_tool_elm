module SurveyResultList.View exposing (view)

{-| Display a survey result list
-}

import Html.Styled exposing (Html, div, h1, h4, img, main_, section, span, text)
import Html.Styled.Attributes exposing (alt, attribute, class, src)
import I18Next exposing (Translations)
import SurveyResult exposing (SurveyResult)
import SurveyResultList.Model exposing (SurveyResultList)


view : (String -> msg) -> Translations -> SurveyResultList -> Html msg
view msg translations { surveyResults } =
    let
        classes =
            [ "center"
            , "mw7"
            ]
                |> String.join " "
    in
        main_ []
            [ section [ attribute "data-name" "survey-results", class classes ]
                (surveyResultList msg translations surveyResults)
            ]


surveyResultList :
    (String -> msg)
    -> Translations
    -> List SurveyResult
    -> List (Html msg)
surveyResultList msg translations surveyResults =
    let
        classes =
            [ "flex"
            , "justify-around"
            , "mt1 mt4-ns"
            ]
                |> String.join " "
    in
        div [ class classes ]
            [ heading translations ]
            :: (surveyResults
                    |> List.map (SurveyResult.view msg translations)
               )


heading : Translations -> Html msg
heading translations =
    let
        headingClasses =
            [ "avenir"
            , "dark-gray"
            , "f2 f-5-ns"
            , "mv3"
            , "ttu"
            ]
                |> String.join " "
    in
        h1 [ class headingClasses ]
            [ text (I18Next.t translations "survey")
            , logo
            , text (I18Next.t translations "results")
            ]


logo : Html msg
logo =
    let
        logoClasses =
            [ "h2 h3-ns"
            , "img"
            , "mh1 mh2-ns"
            , "mt0"
            ]
                |> String.join " "
    in
        img [ src "/logo.png", class logoClasses, alt "logo" ] []
