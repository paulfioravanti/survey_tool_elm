module SurveyResult.Context exposing (Context)

import Locale exposing (Locale)
import Navigation exposing (Location)


type alias Context =
    { locale : Locale
    , location : Location
    }
