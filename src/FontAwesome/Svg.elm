module FontAwesome.Svg exposing (view)

{-| Rendering icons for use in SVG.

@docs view

-}

import FontAwesome.Internal as Icon exposing (Icon(..), IconDef, WithId)
import FontAwesome.Transforms.Internal as Transforms exposing (SvgTransformStyles)
import Svg exposing (Svg)
import Svg.Attributes as SvgA


{-| View an icon as an SVG node.

Note this only supports some features, as some happen at the SVG level. For
example, set titles, attributes, and roles will be ignored.

-}
view : Icon hasId -> Svg msg
view =
    viewInColor "currentColor"


viewInColor : String -> Icon hasId -> Svg msg
viewInColor color ((Icon { icon, transforms, id, outer }) as fullIcon) =
    let
        ( topLevelWidth, _ ) =
            Icon.topLevelDimensions fullIcon

        ( width, _ ) =
            icon.size

        combinedTransforms =
            transforms |> Transforms.meaningfulTransform
    in
    case combinedTransforms of
        Just meaningfulTransform ->
            let
                svgTransform =
                    meaningfulTransform
                        |> Transforms.transformForSvg topLevelWidth width
            in
            case outer of
                Just outerIcon ->
                    viewMaskedWithTransform
                        color
                        svgTransform
                        icon
                        outerIcon

                Nothing ->
                    viewWithTransform color svgTransform icon

        Nothing ->
            viewPaths [ SvgA.fill color ] icon


viewPath : List (Svg.Attribute msg) -> String -> Svg msg
viewPath attrs d =
    Svg.path (SvgA.d d :: attrs) []


viewPaths : List (Svg.Attribute msg) -> IconDef -> Svg msg
viewPaths attrs { paths } =
    case paths of
        ( only, Nothing ) ->
            viewPath attrs only

        ( secondary, Just primary ) ->
            Svg.g [ SvgA.class "fa-group" ]
                [ viewPath (SvgA.class "fa-secondary" :: attrs) secondary
                , viewPath (SvgA.class "fa-primary" :: attrs) primary
                ]


viewWithTransform : String -> SvgTransformStyles msg -> IconDef -> Svg msg
viewWithTransform color { outer, inner, path } icon =
    Svg.g [ outer ]
        [ Svg.g [ inner ]
            [ viewPaths [ SvgA.fill color, path ] icon
            ]
        ]


fill : List (Svg.Attribute msg)
fill =
    [ SvgA.x "0", SvgA.y "0", SvgA.width "100%", SvgA.height "100%" ]


viewMaskedWithTransform : String -> SvgTransformStyles msg -> IconDef -> Icon WithId -> Svg msg
viewMaskedWithTransform color transforms exclude ((Icon { id }) as include) =
    let
        alwaysId =
            id |> Maybe.withDefault ""

        maskId =
            "mask-" ++ alwaysId

        clipId =
            "clip-" ++ alwaysId

        maskTag =
            Svg.mask
                (SvgA.id maskId
                    :: SvgA.maskUnits "userSpaceOnUse"
                    :: SvgA.maskContentUnits "userSpaceOnUse"
                    :: fill
                )
                [ viewInColor "white" include
                , viewWithTransform "black" transforms exclude
                ]

        defs =
            Svg.defs [] [ maskTag ]

        rect =
            Svg.rect
                (SvgA.fill color
                    :: SvgA.mask ("url(#" ++ maskId ++ ")")
                    :: fill
                )
                []
    in
    Svg.g [] [ defs, rect ]
