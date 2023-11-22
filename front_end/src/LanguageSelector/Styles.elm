module LanguageSelector.Styles exposing
    ( countryFlag
    , currentSelection
    , dropdownMenu
    , dropdownMenuCaret
    , dropdownMenuCaretCss
    , dropdownMenuCss
    , dropdownMenuList
    , dropdownMenuListCss
    , dropdownMenuListItem
    , dropdownMenuListItemCss
    )

{-| Language selector-specific styling using CSS and Tachyons.
-}

import Css
    exposing
        ( Style
        , borderColor
        , color
        , hidden
        , hover
        , left
        , marginTop
        , pct
        , rgba
        , visibility
        , visible
        )
import Css.Global as Global
import Styles


countryFlag : String -> String
countryFlag flagClass =
    String.join " "
        [ flagClass
        , "flex-auto"
        ]


currentSelection : Bool -> String
currentSelection showSelectableLanguages =
    let
        borderClass =
            if showSelectableLanguages then
                "b--black-10"

            else
                "b--white"
    in
    String.join " "
        [ borderClass
        , "ba"
        , "bg-white"
        , "flex"
        , "items-center"
        , "mv0"
        , "pa2"
        , "tc"
        ]


dropdownMenu : String
dropdownMenu =
    String.join " "
        [ "relative"
        , "pointer"
        , "w3"
        ]


dropdownMenuCss : Style
dropdownMenuCss =
    hover
        [ Global.children
            [ Global.selector
                "[data-name='language-selector-current-selection']"
                [ borderColor (rgba 0 0 0 0.1) ]
            ]
        , Global.descendants
            [ Global.selector
                "[data-name='language-selector-caret']"
                [ color (rgba 0 0 0 0.2) ]
            ]
        ]


dropdownMenuCaret : Bool -> String
dropdownMenuCaret showSelectableLanguages =
    let
        caretColor =
            if showSelectableLanguages then
                "black-20"

            else
                "white"
    in
    "absolute " ++ caretColor


dropdownMenuCaretCss : Style
dropdownMenuCaretCss =
    left (pct 80)


dropdownMenuList : Bool -> String
dropdownMenuList showSelectableLanguages =
    let
        displayClass =
            if showSelectableLanguages then
                "flex flex-column"

            else
                ""
    in
    String.join " "
        [ displayClass
        , "absolute"
        , "b--black-10"
        , "bb"
        , "bg-white"
        , "bl"
        , "br"
        , "items-center"
        , "list"
        , "ma0"
        , "pa0"
        , "tc"
        , "top-2"
        , "w3"
        ]


dropdownMenuListCss : Bool -> Style
dropdownMenuListCss showSelectableLanguages =
    let
        -- Visibility is used here so that flag images always load upfront, and
        -- there are never any blank menu items when you click the dropdown
        -- menu while you are waiting for them to load
        listVisibility =
            if showSelectableLanguages then
                visibility visible

            else
                visibility hidden
    in
    Css.batch
        [ listVisibility
        , marginTop (Css.rem 0.12)
        ]


dropdownMenuListItem : String
dropdownMenuListItem =
    String.join " "
        [ "pa2"
        , "w-100"
        ]


dropdownMenuListItemCss : Style
dropdownMenuListItemCss =
    hover [ Styles.brandBackgroundColorAlpha ]
