module Translations exposing (..)


type Lang
    = En
    | It
    | Ja


getLnFromCode : String -> Lang
getLnFromCode code =
    case code of
        "en" ->
            En

        "it" ->
            It

        "ja" ->
            Ja

        _ ->
            En


allRespondents : Lang -> String -> String -> String
allRespondents lang str0 str1 =
    case lang of
        En ->
            "Chosen by respondent IDs " ++ str0 ++ ", and " ++ str1 ++ "."

        It ->
            "Scelto da rispondenti con ID " ++ str0 ++ ", e " ++ str1 ++ "."

        Ja ->
            "回答者ID" ++ str0 ++ "と" ++ str1 ++ "が選択"


averageScore : Lang -> String
averageScore lang =
    case lang of
        En ->
            "Average Score"

        It ->
            "Punteggio Medio"

        Ja ->
            "平均点数"


averageSymbol : Lang -> String
averageSymbol lang =
    case lang of
        En ->
            "x"

        It ->
            "x"

        Ja ->
            "x"


backToSurveyResults : Lang -> String
backToSurveyResults lang =
    case lang of
        En ->
            "←  Back to survey results"

        It ->
            "←  Torna ai risultati sondaggio"

        Ja ->
            "←  調査結果一覧表に戻る"


badPayloadMessage : Lang -> String -> String
badPayloadMessage lang str0 =
    case lang of
        En ->
            "Decoding Failed: " ++ str0 ++ ""

        It ->
            "Decodifica Fallita: " ++ str0 ++ ""

        Ja ->
            "デコードが失敗した： " ++ str0 ++ ""


errorRetrievingData : Lang -> String
errorRetrievingData lang =
    case lang of
        En ->
            "Error retrieving data"

        It ->
            "Errore durante lo scaricamento dei dati"

        Ja ->
            "エラーが発生しました。"


loading : Lang -> String
loading lang =
    case lang of
        En ->
            "Loading"

        It ->
            "Caricamento"

        Ja ->
            "ロード中"


networkErrorMessage : Lang -> String
networkErrorMessage lang =
    case lang of
        En ->
            "Is the server running?"

        It ->
            "Il server è in esecuzione?"

        Ja ->
            "サーバーが実行されているか確認ください"


noRespondents : Lang -> String
noRespondents lang =
    case lang of
        En ->
            "Chosen by no respondents."

        It ->
            "Scelto da nessun rispondenti."

        Ja ->
            "選択なし"


notFound : Lang -> String
notFound lang =
    case lang of
        En ->
            "Not Found"

        It ->
            "Non trovato"

        Ja ->
            "ページが見つかりません"


oneRespondent : Lang -> String -> String
oneRespondent lang str0 =
    case lang of
        En ->
            "Chosen by respondent ID " ++ str0 ++ "."

        It ->
            "Scelto da rispondente con ID " ++ str0 ++ "."

        Ja ->
            "回答者ID" ++ str0 ++ "が選択"


other : Lang -> String
other lang =
    case lang of
        En ->
            "other"

        It ->
            "altro"

        Ja ->
            "その他"


others : Lang -> String
others lang =
    case lang of
        En ->
            "others"

        It ->
            "altri"

        Ja ->
            "その他"


participants : Lang -> String
participants lang =
    case lang of
        En ->
            "Participants"

        It ->
            "Partecipanti"

        Ja ->
            "回答者数"


responses : Lang -> String
responses lang =
    case lang of
        En ->
            "Responses"

        It ->
            "Risposte"

        Ja ->
            "回答件数"


responseRate : Lang -> String
responseRate lang =
    case lang of
        En ->
            "Response Rate"

        It ->
            "Tasso di risposta"

        Ja ->
            "回答率"


results : Lang -> String
results lang =
    case lang of
        En ->
            "Results"

        It ->
            "Risultati"

        Ja ->
            "結果"


survey : Lang -> String
survey lang =
    case lang of
        En ->
            "Survey"

        It ->
            "Sondaggio"

        Ja ->
            "調査"


surveyResults : Lang -> String
surveyResults lang =
    case lang of
        En ->
            "Survey Results"

        It ->
            "Risultati Sondaggio"

        Ja ->
            "調査結果"


truncatedRespondents : Lang -> String -> String -> String -> String
truncatedRespondents lang str0 str1 str2 =
    case lang of
        En ->
            "Chosen by respondent IDs " ++ str0 ++ ", and " ++ str1 ++ " " ++ str2 ++ "."

        It ->
            "Scelto da rispondenti con ID " ++ str0 ++ ", e " ++ str1 ++ " " ++ str2 ++ "."

        Ja ->
            "回答者ID" ++ str0 ++ "とその他" ++ str1 ++ "名が選択"
