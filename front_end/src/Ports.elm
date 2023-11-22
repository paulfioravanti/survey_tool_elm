module Ports exposing
    ( initBodyClasses
    , storeLanguage
    )

import Ports.Cmd as Cmd


initBodyClasses : String -> Cmd msg
initBodyClasses classes =
    Cmd.initBodyClasses classes


storeLanguage : String -> Cmd msg
storeLanguage language =
    Cmd.storeLanguage language
