module Fuzzer.SurveyResultDetail exposing (fuzzer)

import Fuzz
    exposing
        ( Fuzzer
        , constant
        , float
        , int
          -- , list
          -- , maybe
        , string
        )
import Question.Model exposing (Question)
import SurveyResponse.Model exposing (SurveyResponse)
import SurveyResult.Model exposing (SurveyResult)
import Theme.Model exposing (Theme)


fuzzer : Fuzzer SurveyResult
fuzzer =
    let
        {- NOTE: Best not to use a theme fuzzer unless you do a low fuzz count
           like 5 (ie elm-test --fuzz 5), as it would seem that it hangs the
           test suite or blows the stack at the default fuzz count of 100.
           Instead, just use a static list of Themes.
        -}
        -- themes =
        --     maybe (list Theme.fuzzer)
        themes : Fuzzer (Maybe (List Theme))
        themes =
            constant
                (Just
                    [ Theme
                        "The Work"
                        [ Question
                            "I like the kind of work I do."
                            [ SurveyResponse 1 1 1 "5" ]
                            "ratingquestion"
                        ]
                    ]
                )
    in
    Fuzz.map SurveyResult string
        |> Fuzz.andMap int
        |> Fuzz.andMap float
        |> Fuzz.andMap int
        |> Fuzz.andMap themes
        |> Fuzz.andMap string
