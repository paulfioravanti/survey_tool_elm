module Utils exposing (percentFromFloat)

{-| Utility functions not specifically tied to an application concern.
-}


{-| Formats a float into a displayable percentage

    percentFromFloat 0.8333333333333334
    --> "83%"

    percentFromFloat 0.8366666666666664
    --> "84%"

-}
percentFromFloat : Float -> String
percentFromFloat float =
    let
        percent : String
        percent =
            float
                * 100
                |> round
                |> String.fromInt
    in
    percent ++ "%"
