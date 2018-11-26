module FontAwesome.Layering exposing
    ( layers, text, textTransformed, counter
    , layersBottomLeft, layersBottomRight, layersTopLeft, layersTopRight
    )

{-| Layers are the way to place icons and text visually on top of each other. With this approach you can use more than
two icons, use multiple colors, and layer text and/or counters onto an icon.

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/layering)

@docs layers, text, textTransformed, counter

There are also some attributes to control positioning of counters.

@docs layersBottomLeft, layersBottomRight, layersTopLeft, layersTopRight

-}

import FontAwesome.Transforms exposing (..)
import FontAwesome.Transforms.Internal exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlA
import Svg.Attributes as SvgA


{-| Convenience function for producing layers of icons.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
layers : List (Html.Attribute msg) -> List (Html msg) -> Html msg
layers attrs icons =
    Html.span (SvgA.class "fa-layers fa-fw" :: attrs) icons


{-| Add inside your `layers` element to put text on top of an icon.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
text : List (Html.Attribute msg) -> String -> Html msg
text attrs str =
    textTransformed attrs [] str


{-| Add inside your `layers` element to put text on top of an icon, applying the given transforms to it.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
textTransformed : List (Html.Attribute msg) -> List Transform -> String -> Html msg
textTransformed attrs transforms str =
    let
        transform =
            transforms |> meaningfulTransform |> Maybe.map transformForCss |> Maybe.withDefault []
    in
    Html.span
        (List.concat [ [ SvgA.class "fa-layers-text", HtmlA.attribute "aria-hidden" "true" ], transform, attrs ])
        [ Html.text str ]


{-| Adds a counter to the top right of your icons. Can be positioned with `layersBottomLeft`, `layersBottomRight`,
`layersTopLeft` and the default `layersTopRight`. Overflow text is truncated with an ellipsis.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
counter : List (Html.Attribute msg) -> String -> Html msg
counter attrs count =
    Html.span (SvgA.class "fa-layers-counter" :: attrs) [ Html.text count ]


{-| Apply the `fa-layers-bottom-left` class to the element.
-}
layersBottomLeft : Html.Attribute msg
layersBottomLeft =
    SvgA.class "fa-layers-bottom-left"


{-| Apply the `fa-layers-bottom-right` class to the element.
-}
layersBottomRight : Html.Attribute msg
layersBottomRight =
    SvgA.class "fa-layers-bottom-right"


{-| Apply the `fa-layers-top-left` class to the element.
-}
layersTopLeft : Html.Attribute msg
layersTopLeft =
    SvgA.class "fa-layers-top-left"


{-| Apply the `fa-layers-top-right` class to the element.
-}
layersTopRight : Html.Attribute msg
layersTopRight =
    SvgA.class "fa-layers-top-right"



{- Private -}


transformForCss : CombinedTransform -> List (Html.Attribute msg)
transformForCss transform =
    let
        translate =
            "translate(calc(-50% + " ++ String.fromFloat (transform.x / baseSize) ++ "em), calc(-50% + " ++ String.fromFloat (transform.y / baseSize) ++ "em)) "

        flipX =
            if transform.flipX then
                -1

            else
                1

        flipY =
            if transform.flipY then
                -1

            else
                1

        scaleX =
            transform.size / baseSize * flipX

        scaleY =
            transform.size / baseSize * flipY

        scale =
            "scale(" ++ String.fromFloat scaleX ++ ", " ++ String.fromFloat scaleY ++ ") "

        rotate =
            "rotate(" ++ String.fromFloat transform.rotate ++ "deg)"
    in
    [ HtmlA.style "transform" (translate ++ scale ++ rotate) ]
