module FontAwesome.Icon exposing
    ( Icon
    , viewIcon, viewStyled, viewTransformed
    , Presentation, WithId, WithoutId
    , present, view
    , styled, transform
    , withId
    , titled, masked
    )

{-| Rendering icons for use in HTML.

Most users will be able to just use the simple `viewIcon`, `viewStyled` and `viewTransformed` methods, but if you want
to use the more powerful features, this library uses a pipeline style to define the various potential parameters for
rendering an icon. In general, the base for rendering an icon is:

    icon |> present |> view

Extra steps can be placed between `present` and `view` to customise the way the icon is rendered.

@docs Icon

@docs viewIcon, viewStyled, viewTransformed

@docs Presentation, WithId, WithoutId

@docs present, view

@docs styled, transform

@docs withId

@docs titled, masked

-}

import FontAwesome.Transforms exposing (..)
import FontAwesome.Transforms.Internal exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlA
import Svg exposing (Svg)
import Svg.Attributes as SvgA


{-| The definition of an icon.

You should never need to define these or change them yourself. You will find these in the modules for the different
Icon packs (e.g: `FontAwesome.Solid`).

-}
type alias Icon =
    { prefix : String
    , name : String
    , width : Int
    , height : Int
    , paths : List String
    }


{-| A convenience function to render an icon.

`viewIcon icon` is directly equivalent to directly equivalent to `icon |> present |> view`.

-}
viewIcon : Icon -> Html msg
viewIcon =
    present >> view


{-| A convenience function to render an icon with some custom styles.

`viewStyled styles icon` is directly equivalent to directly equivalent to
`icon |> present |> styled styles |> view`.

-}
viewStyled : List (Svg.Attribute msg) -> Icon -> Html msg
viewStyled styles =
    present >> styled styles >> view


{-| A convenience function to render an icon with some custom styles.

`viewTransformed styles transforms icon` is directly equivalent to
`icon |> present |> styled styles |> transform transforms |> view`.

-}
viewTransformed : List (Svg.Attribute msg) -> List Transform -> Icon -> Html msg
viewTransformed styles transforms =
    present >> styled styles >> transform transforms >> view


{-| Information on how an icon should be rendered. In general, you shouldn't need to interact directly with this type -
it should generally only exist in a chain of operations to display an icon.

Adding titles or using masking require that the icon has a unique id. This is because references are made in the HTML
via the HTML `id` attribute, which must be unique on the page. Views with an id will have the `WithId`
type and will therefore work with those options, while ones that have the `WithoutId` type won't.

-}
type Presentation identification msg
    = Presentation
        { icon : Icon
        , attributes : List (Svg.Attribute msg)
        , transforms : List Transform
        , role : String
        , id : Maybe String
        , title : Maybe String
        , outer : Maybe Icon
        }


{-| Indicates that the presentation has an id, which lets you use `titled` and `masked`. For more on why those features
are "locked" like this, see the documentation for the `View` type above.
-}
type WithId
    = WithId


{-| Indicates that the presentation does not have an id, which means you can't use `titled` and `masked`. For more on
why those features are "locked" like this, see the documentation for the `View` type above.
-}
type WithoutId
    = WithoutId


{-| Gets a basic presentation of an icon.

If you do nothing else an pass this to view, the icon will be presented as semantically meaningless (i.e: purely
decorative) and will be hidden from accessibility tools. If you need the icon to have semantic meaning then using
`titled` will change that.

-}
present : Icon -> Presentation WithoutId msg
present icon =
    Presentation
        { icon = icon
        , attributes = []
        , transforms = []
        , role = "img"
        , id = Nothing
        , title = Nothing
        , outer = Nothing
        }


{-| Render the given icon presentation to HTML. Take a look at `present` to get that presentation.
-}
view : Presentation identification msg -> Html msg
view presentation =
    internalView presentation


{-| Add the given attributes to the icon's presentation. These will be applied to the icon when viewed.

Note the icon is an `svg` tag, and it appears that using `Html.Attribute.class` will remove any `Svg.Attribute.class`
values that are set, including FontAwesome ones that make the icon work, so make sure to use `Svg.Attribute.class` with
this.

-}
styled : List (Svg.Attribute msg) -> Presentation identification msg -> Presentation identification msg
styled attributes (Presentation presentation) =
    Presentation { presentation | attributes = presentation.attributes ++ attributes }


{-| Add the given transforms to the icon's presentation. These will be applied to the icon when viewed.
-}
transform : List Transform -> Presentation identification msg -> Presentation identification msg
transform transforms (Presentation presentation) =
    Presentation { presentation | transforms = presentation.transforms ++ transforms }


{-| Set [the HTML role](https://www.w3.org/TR/wai-aria/#usage_intro) for the icon. By default, this is `"img"`.
-}
withRole : String -> Presentation identification msg -> Presentation identification msg
withRole role (Presentation presentation) =
    Presentation { presentation | role = role }


{-| Set the HTML id for the icon presentation to the given value. This must be unique on the page.

The FontAwesome JavaScript library generates random ids for this. Doing this in elm is a little more cumbersome, but
is possible if you need to dynamically generate items and don't have existing ids to work from. Please see
[the `elm-fontawesome-example` repository](https://github.com/Lattyware/elm-fontawesome-example) for an example of this.

-}
withId : String -> Presentation WithoutId msg -> Presentation WithId msg
withId id (Presentation presentation) =
    Presentation { presentation | id = Just id }


{-| Sets the title of the presented icon. This will make the icon semantically meaningful, and as such it won't be
hidden from accessibility tools.

Note that this can only be applied where the icon has an id unique on the page as it uses that id under the hood in the
HTML. Use `withId` to add one.

-}
titled : String -> Presentation WithId msg -> Presentation WithId msg
titled title (Presentation presentation) =
    Presentation { presentation | title = Just title }


{-| Sets an outer icon that the main icon is masking (i.e.: the initial icon will become a "cut out" of this outer
icon). This creates true transparency.

Note that this can only be applied where the icon has an id unique on the page as it uses that id under the hood in the
HTML. Use `withId` to add one.

-}
masked : Icon -> Presentation WithId msg -> Presentation WithId msg
masked outer (Presentation presentation) =
    Presentation { presentation | outer = Just outer }



{- Private -}


internalView : Presentation identification msg -> Html msg
internalView (Presentation { icon, attributes, transforms, role, id, title, outer }) =
    let
        ( width, height ) =
            outer |> Maybe.map (\o -> ( o.width, o.height )) |> Maybe.withDefault ( icon.width, icon.height )

        -- We type guard this with the WithId/WithoutId stuff, so if this gets used, it should never be Nothing.
        alwaysId =
            id |> Maybe.withDefault icon.name

        titleId =
            alwaysId ++ "-title"

        semantics =
            title
                |> Maybe.map (always (HtmlA.attribute "aria-labelledby" titleId))
                |> Maybe.withDefault (HtmlA.attribute "aria-hidden" "true")

        svgTransform =
            transforms |> meaningfulTransform |> Maybe.map (transformForSvg width icon.width)

        classes =
            [ "svg-inline--fa"
            , "fa-" ++ icon.name
            , "fa-w-" ++ (ceiling (toFloat width / toFloat height * 16) |> String.fromInt)
            ]

        contents =
            let
                resolvedSvgTransform =
                    svgTransform |> Maybe.withDefault (transformForSvg width icon.width meaninglessTransform)
            in
            outer
                |> Maybe.map (viewMaskedWithTransform alwaysId resolvedSvgTransform icon)
                |> Maybe.withDefault [ viewWithTransform svgTransform icon ]

        potentiallyTitledContents =
            title |> Maybe.map (titledContents titleId contents) |> Maybe.withDefault contents
    in
    Svg.svg
        (List.concat
            [ [ HtmlA.attribute "role" role
              , HtmlA.attribute "xmlns" "http://www.w3.org/2000/svg"
              , SvgA.viewBox ("0 0 " ++ String.fromInt width ++ " " ++ String.fromInt height)
              , semantics
              ]
            , classes |> List.map SvgA.class
            , attributes
            ]
        )
        potentiallyTitledContents


titledContents : String -> List (Html msg) -> String -> List (Html msg)
titledContents titleId contents title =
    Svg.title [ SvgA.id titleId ] [ Svg.text title ] :: contents


allSpace : List (Svg.Attribute msg)
allSpace =
    [ SvgA.x "0", SvgA.y "0", SvgA.width "100%", SvgA.height "100%" ]


viewWithTransform : Maybe (SvgTransformStyles msg) -> Icon -> Svg msg
viewWithTransform transforms icon =
    case transforms of
        Just ts ->
            Svg.g [ ts.outer ]
                [ Svg.g [ ts.inner ]
                    [ corePaths [ ts.path ] icon
                    ]
                ]

        Nothing ->
            corePaths [] icon


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


viewMaskedWithTransform : String -> SvgTransformStyles msg -> Icon -> Icon -> List (Svg msg)
viewMaskedWithTransform id transforms inner outer =
    let
        maskInnerGroup =
            Svg.g [ transforms.inner ] [ corePaths [ SvgA.fill "black", transforms.path ] inner ]

        maskId =
            "mask-" ++ inner.name ++ "-" ++ id

        clipId =
            "clip-" ++ outer.name ++ "-" ++ id

        maskTag =
            Svg.mask
                ([ SvgA.id maskId, SvgA.maskUnits "userSpaceOnUse", SvgA.maskContentUnits "userSpaceOnUse" ] ++ allSpace)
                [ Svg.rect (SvgA.fill "white" :: allSpace) [], Svg.g [ transforms.outer ] [ maskInnerGroup ] ]

        defs =
            Svg.defs [] [ Svg.clipPath [ SvgA.id clipId ] [ corePaths [] outer ], maskTag ]
    in
    [ defs
    , Svg.rect
        (List.concat
            [ [ SvgA.fill "currentColor"
              , SvgA.clipPath ("url(#" ++ clipId ++ ")")
              , SvgA.mask ("url(#" ++ maskId ++ ")")
              ]
            , allSpace
            ]
        )
        []
    ]
