module SurveyResult.Config exposing (Config)


type alias Config msg =
    { surveyResultDetailMsg : String -> msg }
