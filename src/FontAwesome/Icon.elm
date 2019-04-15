module FontAwesome.Icon exposing
    ( view, viewStyled, viewTransformed, viewMasked, viewTitled, viewWithId
    , Icon
    )

{-| Rendering icons for use in HTML.

Note the various view methods are all just convenience wrappers of `viewWithId`. It may make sense to create your own
wrapper method with just the functionality you need if the given ones don't match your use case.

The "defaults" as called by `view` would be: `viewWithId icon.name [] [] Nothing Nothing icon`.

@docs view, viewStyled, viewTransformed, viewMasked, viewTitled, viewWithId
@docs Icon

-}

import FontAwesome.Transforms exposing (..)
import FontAwesome.Transforms.Internal exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlA
import Svg exposing (Svg)
import Svg.Attributes as SvgA


{-| The definition of an icon.
-}
type alias Icon =
    { prefix : String
    , name : String
    , width : Int
    , height : Int
    , path : String
    }


{-| A convenience method for simply rendering the icon.
-}
view : Icon -> Html msg
view =
    viewStyled []


{-| A convenience method for simply rendering the icon with some additional styles.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
viewStyled : List (Svg.Attribute msg) -> Icon -> Html msg
viewStyled attrs =
    viewTransformed attrs []


{-| Render the icon with some transforms. Also takes additional attributes to be applied to the SVG node, should you
wish to supply any.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
viewTransformed : List (Svg.Attribute msg) -> List Transform -> Icon -> Html msg
viewTransformed attrs transforms icon =
    viewMasked attrs transforms Nothing icon


{-| Render one icon as a mask over the other - this means that the inner icon (given second) is cut out of the outer
icon. The big difference between this and layering is that the background can show through, as the cut out icon becomes
a truly transparent area (not just the same color as the background).

Note this sets IDs in order to achieve masking. If you use the same inner icon more than once on a page,
you should use `viewWithId` instead and pass a unique ID for each element to avoid repeated IDs.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
viewMasked : List (Svg.Attribute msg) -> List Transform -> Maybe Icon -> Icon -> Html msg
viewMasked attrs transforms outer inner =
    viewTitled attrs transforms Nothing outer inner


{-| Render as in viewMasked, but with an optional title element in the SVG for accessibility.

If a title is provided, the element is considered a semantic icon, and `aria-hidden` will not be set.
If a title is not provided then the element is assumed to be purely decorative, and `aria-hidden` is set.

Note this sets an ID for the `aria-labelledby` element. If you use the same inner icon titled more than once on a page,
you should use `viewWithId` instead and pass a unique ID for each element to avoid repeated IDs.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
viewTitled : List (Svg.Attribute msg) -> List Transform -> Maybe String -> Maybe Icon -> Icon -> Html msg
viewTitled attrs transforms title outer inner =
    viewWithId inner.name attrs transforms title outer inner


{-| Render as in viewTitled, but with a provided unique ID. This allows you to avoid overlapping IDs if the same
elements are repeated for correctness.

If you want to add a class, make sure to use `Svg.Attributes.class` not `Html.Attributes.class`.

-}
viewWithId : String -> List (Svg.Attribute msg) -> List Transform -> Maybe String -> Maybe Icon -> Icon -> Html msg
viewWithId id attrs transforms title outer inner =
    let
        ( width, height ) =
            case outer of
                Just mask ->
                    ( mask.width, mask.height )

                Nothing ->
                    ( inner.width, inner.height )

        titleId =
            id ++ "-title"

        attrsAdded =
            case title of
                Just _ ->
                    HtmlA.attribute "aria-labelledby" titleId :: attrs

                Nothing ->
                    HtmlA.attribute "aria-hidden" "true" :: attrs

        svgTransform =
            transforms |> meaningfulTransform |> Maybe.map (transformForSvg width inner.width)

        classes =
            "svg-inline--fa fa-" ++ inner.name ++ " fa-w-" ++ (ceiling (toFloat width / toFloat height * 16) |> String.fromInt)

        contents =
            case outer of
                Just mask ->
                    viewMaskedWithTransform id (svgTransform |> Maybe.withDefault (transformForSvg width inner.width meaninglessTransform)) mask inner

                Nothing ->
                    [ viewWithTransform svgTransform inner ]

        contentsWithTitle =
            case title of
                Just t ->
                    Svg.title [ SvgA.id titleId ] [ Svg.text t ] :: contents

                Nothing ->
                    contents
    in
    Svg.svg
        ([ SvgA.class classes
         , HtmlA.attribute "role" "img"
         , HtmlA.attribute "xmlns" "http://www.w3.org/2000/svg"
         , SvgA.viewBox ("0 0 " ++ String.fromInt width ++ " " ++ String.fromInt height)
         ]
            ++ attrsAdded
        )
        contentsWithTitle



{- Private -}


viewWithTransform : Maybe (SvgTransformStyles msg) -> Icon -> Svg msg
viewWithTransform transform icon =
    case transform of
        Just trans ->
            Svg.g [ trans.outer ]
                [ Svg.g [ trans.inner ]
                    [ corePath [ trans.path ] icon
                    ]
                ]

        Nothing ->
            corePath [] icon


corePath : List (Svg.Attribute msg) -> Icon -> Svg msg
corePath attrs icon =
    Svg.path ([ SvgA.fill "currentColor", SvgA.d icon.path ] ++ attrs) []


allSpace : List (Svg.Attribute msg)
allSpace =
    [ SvgA.x "0", SvgA.y "0", SvgA.width "100%", SvgA.height "100%" ]


viewMaskedWithTransform : String -> SvgTransformStyles msg -> Icon -> Icon -> List (Svg msg)
viewMaskedWithTransform id transform outer inner =
    let
        maskRect =
            Svg.rect (SvgA.fill "white" :: allSpace) []

        maskInnerGroup =
            Svg.g [ transform.inner ] [ Svg.path [ transform.path, SvgA.fill "black", SvgA.d inner.path ] [] ]

        maskOuterGroup =
            Svg.g [ transform.outer ] [ maskInnerGroup ]

        maskId =
            "mask-" ++ inner.name ++ "-" ++ id

        clipId =
            "clip-" ++ outer.name ++ "-" ++ id

        maskTag =
            Svg.mask
                ([ SvgA.id maskId, SvgA.maskUnits "userSpaceOnUse", SvgA.maskContentUnits "userSpaceOnUse" ] ++ allSpace)
                [ maskRect, maskOuterGroup ]

        defs =
            Svg.defs [] [ Svg.clipPath [ SvgA.id clipId ] [ corePath [] outer ], maskTag ]
    in
    [ defs
    , Svg.rect
        ([ SvgA.fill "currentColor"
         , SvgA.clipPath ("url(#" ++ clipId ++ ")")
         , SvgA.mask ("url(#" ++ maskId ++ ")")
         ]
            ++ allSpace
        )
        []
    ]
