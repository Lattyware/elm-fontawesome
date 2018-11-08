module FontAwesome.Icon exposing (Icon, view)

import Html exposing (Html)
import Html.Attributes as HtmlA
import Svg
import Svg.Attributes as SvgA


{-| A type for the data required to construct an icon's view.
-}
type alias Icon =
    { prefix : String
    , name : String
    , class : String
    , viewBox : String
    , path : String
    }


{-| Render the icon.
-}
view : Icon -> List (Svg.Attribute msg) -> Html msg
view icon attrs =
    Svg.svg
        ([ HtmlA.attribute "data-prefix" icon.prefix
         , HtmlA.attribute "data-icon" icon.name
         , SvgA.class icon.class
         , HtmlA.attribute "role" "img"
         , HtmlA.attribute "aria-hidden" "true"
         , HtmlA.attribute "xmlns" "http://www.w3.org/2000/svg"
         , SvgA.viewBox icon.viewBox
         ]
            ++ attrs
        )
        [ Svg.path [ SvgA.fill "currentColor", SvgA.d icon.path ] [] ]
