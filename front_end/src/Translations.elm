module Translations exposing
    ( allRespondents
    , averageScore
    , averageSymbol
    , backToSurveyResults
    , badBodyMessage
    , errorRetrievingData
    , loading
    , networkErrorMessage
    , noRespondents
    , notFound
    , oneRespondent
    , other
    , otherErrorMessage
    , others
    , participants
    , responseRate
    , responses
    , surveyResults
    , truncatedRespondents
    )

import Language exposing (Language)


allRespondents : Language -> String -> String -> String
allRespondents language str0 str1 =
    case language of
        Language.En ->
            "Chosen by respondent IDs " ++ str0 ++ ", and " ++ str1 ++ "."

        Language.It ->
            "Scelto da rispondenti con ID " ++ str0 ++ ", e " ++ str1 ++ "."

        Language.Ja ->
            "回答者ID" ++ str0 ++ "と" ++ str1 ++ "が選択"


averageScore : Language -> String
averageScore language =
    case language of
        Language.En ->
            "Average Score"

        Language.It ->
            "Punteggio Medio"

        Language.Ja ->
            "平均点数"


averageSymbol : Language -> String
averageSymbol language =
    case language of
        Language.En ->
            "x"

        Language.It ->
            "x"

        Language.Ja ->
            "x"


backToSurveyResults : Language -> String
backToSurveyResults language =
    case language of
        Language.En ->
            "←  Back to survey results"

        Language.It ->
            "←  Torna ai risultati sondaggio"

        Language.Ja ->
            "←  調査結果一覧表に戻る"


badBodyMessage : Language -> String -> String
badBodyMessage lang message =
    case lang of
        Language.En ->
            "Decoding Failed: " ++ message ++ ""

        Language.It ->
            "Decodifica Fallita: " ++ message ++ ""

        Language.Ja ->
            "デコードが失敗した： " ++ message ++ ""


errorRetrievingData : Language -> String
errorRetrievingData language =
    case language of
        Language.En ->
            "Error retrieving data"

        Language.It ->
            "Errore durante lo scaricamento dei dati"

        Language.Ja ->
            "エラーが発生しました"


loading : Language -> String
loading language =
    case language of
        Language.En ->
            "Loading"

        Language.It ->
            "Caricamento"

        Language.Ja ->
            "ロード中"


networkErrorMessage : Language -> String
networkErrorMessage language =
    case language of
        Language.En ->
            "Is the server running?"

        Language.It ->
            "Il server è in esecuzione?"

        Language.Ja ->
            "サーバーが実行されているか確認ください"


noRespondents : Language -> String
noRespondents language =
    case language of
        Language.En ->
            "Chosen by no respondents."

        Language.It ->
            "Scelto da nessun rispondenti."

        Language.Ja ->
            "選択なし"


notFound : Language -> String
notFound language =
    case language of
        Language.En ->
            "Not Found"

        Language.It ->
            "Non Trovato"

        Language.Ja ->
            "ページが見つかりません"


oneRespondent : Language -> String -> String
oneRespondent language str0 =
    case language of
        Language.En ->
            "Chosen by respondent ID " ++ str0 ++ "."

        Language.It ->
            "Scelto da rispondente con ID " ++ str0 ++ "."

        Language.Ja ->
            "回答者ID" ++ str0 ++ "が選択"


other : Language -> String
other language =
    case language of
        Language.En ->
            "other"

        Language.It ->
            "altro"

        Language.Ja ->
            "その他"


otherErrorMessage : Language -> String
otherErrorMessage language =
    case language of
        Language.En ->
            "Something went wrong"

        Language.It ->
            "Errore sconosciuto"

        Language.Ja ->
            "エラーが発生しました"


others : Language -> String
others language =
    case language of
        Language.En ->
            "others"

        Language.It ->
            "altri"

        Language.Ja ->
            "その他"


participants : Language -> String
participants language =
    case language of
        Language.En ->
            "Participants"

        Language.It ->
            "Partecipanti"

        Language.Ja ->
            "回答者数"


responseRate : Language -> String
responseRate language =
    case language of
        Language.En ->
            "Response Rate"

        Language.It ->
            "Tasso di risposta"

        Language.Ja ->
            "回答率"


responses : Language -> String
responses language =
    case language of
        Language.En ->
            "Responses"

        Language.It ->
            "Risposte"

        Language.Ja ->
            "回答件数"


surveyResults : Language -> String
surveyResults language =
    case language of
        Language.En ->
            "Survey Results"

        Language.It ->
            "Risultati Sondaggio"

        Language.Ja ->
            "調査結果"


truncatedRespondents : Language -> String -> String -> String -> String
truncatedRespondents language str0 str1 str2 =
    case language of
        Language.En ->
            "Chosen by respondent IDs "
                ++ str0
                ++ ", and "
                ++ str1
                ++ " "
                ++ str2
                ++ "."

        Language.It ->
            "Scelto da rispondenti con ID "
                ++ str0
                ++ ", e "
                ++ str1
                ++ " "
                ++ str2
                ++ "."

        Language.Ja ->
            "回答者ID"
                ++ str0
                ++ "とその他"
                ++ str1
                ++ "名が選択"
