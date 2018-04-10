module Utils exposing (toFormattedPercentage)

import Regex exposing (HowMany(AtMost))


{-| Formats a float into a displayable percentage

    toFormattedPercentage 0.8333333333333334
    --> "83%"

    toFormattedPercentage 0.8366666666666664
    --> "84%"

-}
toFormattedPercentage : Float -> String
toFormattedPercentage float =
    let
        percent =
            float
                * 100
                |> round
                |> toString
    in
        percent ++ "%"
