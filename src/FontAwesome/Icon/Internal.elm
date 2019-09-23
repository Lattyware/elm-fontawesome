module FontAwesome.Icon.Internal exposing (Icon)

{-| Internal module to avoid a dependency cycle.
-}


{-| This must remain the same as the definition for `Icon.Icon`.
-}
type alias Icon =
    { prefix : String
    , name : String
    , width : Int
    , height : Int
    , paths : List String
    }
