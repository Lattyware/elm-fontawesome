module FontAwesome.Svg.Internal exposing (corePath, corePaths)

import FontAwesome.Icon.Internal exposing (Icon)
import Svg exposing (Svg)
import Svg.Attributes as SvgA


corePaths : List (Svg.Attribute msg) -> Icon -> Svg msg
corePaths attrs icon =
    case icon.paths of
        [] ->
            corePath attrs ""

        only :: [] ->
            corePath attrs only

        secondary :: primary :: _ ->
            Svg.g [ SvgA.class "fa-group" ]
                [ corePath (SvgA.class "fa-secondary" :: attrs) secondary
                , corePath (SvgA.class "fa-primary" :: attrs) primary
                ]


corePath : List (Svg.Attribute msg) -> String -> Svg msg
corePath attrs d =
    Svg.path (SvgA.fill "currentColor" :: SvgA.d d :: attrs) []
