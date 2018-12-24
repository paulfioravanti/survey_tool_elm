port module Ports exposing (initBodyProperties, storeLanguage)


port initBodyProperties : String -> Cmd msg


port storeLanguage : String -> Cmd msg
