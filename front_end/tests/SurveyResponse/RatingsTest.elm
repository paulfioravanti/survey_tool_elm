module SurveyResponse.RatingsTest exposing (all)

import Expect
import SurveyResponse
import Test exposing (Test, describe, test)


all : Test
all =
    let
        expectedRatings : List String
        expectedRatings =
            [ "1", "2", "3", "4", "5" ]

        actualRatings : List String
        actualRatings =
            SurveyResponse.ratings
    in
    describe "SurveyResponse.ratings"
        [ test "returns the list of valid ratings 1-5" <|
            \() ->
                Expect.equal expectedRatings actualRatings
        ]
