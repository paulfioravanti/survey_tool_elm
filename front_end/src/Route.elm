module Route exposing (Route(..), init, toString)

import Url exposing (Url)
import Url.Parser as Parser
    exposing
        ( (</>)
        , Parser
        , map
        , oneOf
        , s
        , string
        , top
        )


type Route
    = SurveyResultList
    | SurveyResultDetail String


{-| Translates a url into a Route

    import Route
    import Url exposing (Url)

    urlFor : String -> Url
    urlFor path =
        let
            fourOhFourUrl =
                Url Url.Https "example.com" (Just 443) "/" Nothing Nothing
        in
        ("https://www.example.com" ++ path)
            |> Url.fromString
            |> Maybe.withDefault fourOhFourUrl

    init (urlFor "/")
    --> Just Route.SurveyResultList

    init (urlFor "/survey_results")
    --> Just Route.SurveyResultList

    init (urlFor "/survey_results/11")
    --> Just (Route.SurveyResultDetail "11")

    init (urlFor "/invalid-path")
    --> Nothing

-}
init : Url -> Maybe Route
init url =
    Parser.parse matchers url


{-| Translates a Route into a path string

    import Route

    toString Route.SurveyResultList
    --> "/survey_results/"

    toString (Route.SurveyResultDetail "11")
    --> "/survey_results/11/"

-}
toString : Route -> String
toString route =
    case route of
        SurveyResultList ->
            "/survey_results/"

        SurveyResultDetail id ->
            "/survey_results/" ++ id ++ "/"



-- PRIVATE


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map SurveyResultList top
        , map SurveyResultList (s "survey_results")
        , map SurveyResultDetail (s "survey_results" </> string)
        ]
