module FontAwesome exposing
    ( Icon, WithId, WithoutId
    , view
    , styled, transform
    , withId
    , titled, masked
    , IconDef, present
    )

{-| Rendering icons for use in HTML.

This library is designed with a pipeline style, at its simplest:

    icon |> view

More complex pipelines can be created by adding steps between these.

@docs Icon, WithId, WithoutId

@docs view

@docs styled, transform

@docs withId

@docs titled, masked

@docs IconDef, present

-}

import FontAwesome.Internal as Internal exposing (Icon(..), WithId, WithoutId)
import FontAwesome.Svg as IconSvg
import FontAwesome.Transforms exposing (..)
import FontAwesome.Transforms.Internal exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlA
import Svg exposing (Svg)
import Svg.Attributes as SvgA


{-| The definition of an icon.

You will find these in the modules for the different IconDef packs (e.g: `FontAwesome.Solid.Definition`).
You should never need to define these or change them yourself (but you can to create custom icons).

Generally you want to work with `Icon` instead, which can be found in the parent packs.

-}
type alias IconDef =
    { prefix : String
    , name : String
    , size : ( Int, Int )
    , paths : ( String, Maybe String )
    }


{-| Information on how an icon should be rendered. In general, you shouldn't need to interact directly with this type -
it should generally only exist in a chain of operations to display an icon.

Adding titles or using masking require that the icon has a unique id. This is because references are made in the HTML
via the HTML `id` attribute, which must be unique on the page. Views with an id will have the `WithId`
type and will therefore work with those options, while ones that have the `WithoutId` type won't.

-}
type alias Icon hasId =
    Internal.Icon hasId


{-| Indicates that the presentation has an id, which lets you use `titled` and `masked`. For more on why those features
are "locked" like this, see the documentation for the `View` type above.
-}
type alias WithId =
    Internal.WithId


{-| Indicates that the presentation does not have an id, which means you can't use `titled` and `masked`. For more on
why those features are "locked" like this, see the documentation for the `View` type above.
-}
type alias WithoutId =
    Internal.WithoutId


def =
    IconDef


{-| Gets a basic presentation of an icon.

If you do nothing else an pass this to view, the icon will be presented as semantically meaningless (i.e: purely
decorative) and will be hidden from accessibility tools. If you need the icon to have semantic meaning then using
`titled` will change that.

-}
present : IconDef -> Icon WithoutId
present icon =
    Icon
        { icon = icon
        , transforms = []
        , role = "img"
        , id = Nothing
        , title = Nothing
        , outer = Nothing
        , attributes = []
        }


{-| Render the given icon to HTML.
-}
view : Icon hasId -> Html msg
view presentation =
    internalView presentation []


{-| Render the given icon to HTML with custom attributes applied.

Please note this takes `Svg.Attribute`s, and while `Html.Attribute`s will pass the type check, they are
not compatible and may not work or even result in errors if used. Please be sure to use `Svg.Attribute`s
instead.

Generally you just want to use `styled` instead, but this lets you use
`Svg.Attributes` that can produce messsages.

-}
viewWithAttributes : Icon hasId -> List (Svg.Attribute msg) -> Html msg
viewWithAttributes presentation attributes =
    internalView presentation attributes


{-| Add the given attributes to the icon's presentation. These will be applied to the icon when viewed.
Note the icon is an `svg` tag, and it appears that using `Html.Attribute.class` will remove any `Svg.Attribute.class`
values that are set, including FontAwesome ones that make the icon work, so make sure to use `Svg.Attribute.class` with
this.

Due to this taking `Svg.Attribute Never` you can't use attributes that can
produce messages. You can use `viewWithAttributes` to add such attributes if
required.

-}
styled : List (Svg.Attribute Never) -> Icon hasId -> Icon hasId
styled attributes (Icon presentation) =
    Icon { presentation | attributes = presentation.attributes ++ attributes }


{-| Add the given transforms to the icon's presentation. These will be applied to the icon when viewed.
-}
transform : List Transform -> Icon hasId -> Icon hasId
transform transforms (Icon presentation) =
    Icon { presentation | transforms = presentation.transforms ++ transforms }


{-| Set [the HTML role](https://www.w3.org/TR/wai-aria/#usage_intro) for the icon. By default, this is `"img"`.
-}
withRole : String -> Icon hasId -> Icon hasId
withRole role (Icon presentation) =
    Icon { presentation | role = role }


{-| Set the HTML id for the icon presentation to the given value. This must be unique on the page.

The FontAwesome JavaScript library generates random ids for this. Doing this in elm is a little more cumbersome, but
is possible if you need to dynamically generate items and don't have existing ids to work from. Please see
[the `elm-fontawesome-example` repository](https://github.com/Lattyware/elm-fontawesome-example) for an example of this.

-}
withId : String -> Icon WithoutId -> Icon WithId
withId id (Icon presentation) =
    Icon { presentation | id = Just id }


{-| Sets the title of the presented icon. This will make the icon semantically meaningful, and as such it won't be
hidden from accessibility tools.

Note that this can only be applied where the icon has an id unique on the page as it uses that id under the hood in the
HTML. Use `withId` to add one.

-}
titled : String -> Icon WithId -> Icon WithId
titled title (Icon presentation) =
    Icon { presentation | title = Just title }


{-| Sets an outer icon that the main icon is masking (i.e.: the initial icon will become a "cut out" of this outer
icon). This creates true transparency.

Note that this can only be applied where the icon to be masked has an id unique on the page as it uses that id under the
hood in the HTML. Use `withId` to add one.

-}
masked : Icon WithId -> Icon hasId -> Icon hasId
masked outer (Icon presentation) =
    Icon { presentation | outer = Just outer }



{- Private -}


internalView : Icon hasId -> List (Svg.Attribute msg) -> Html msg
internalView ((Icon { icon, transforms, role, id, title, outer, attributes }) as fullIcon) extraAttributes =
    let
        ( width, height ) =
            Internal.topLevelDimensions fullIcon

        aspectRatio =
            (toFloat width / toFloat height * 16) |> ceiling

        classes =
            [ "svg-inline--fa"
            , "fa-" ++ icon.name
            , "fa-w-" ++ (aspectRatio |> String.fromInt)
            ]

        contents =
            IconSvg.view fullIcon

        ( semantics, potentiallyTitledContents ) =
            case title of
                Just givenTitle ->
                    let
                        titleId =
                            (id |> Maybe.withDefault "") ++ "-title"
                    in
                    ( HtmlA.attribute "aria-labelledby" titleId
                    , [ Svg.title [ SvgA.id titleId ] [ Svg.text givenTitle ], contents ]
                    )

                Nothing ->
                    ( HtmlA.attribute "aria-hidden" "true", [ contents ] )
    in
    Svg.svg
        (List.concat
            [ [ HtmlA.attribute "role" role
              , HtmlA.attribute "xmlns" "http://www.w3.org/2000/svg"
              , SvgA.viewBox ("0 0 " ++ String.fromInt width ++ " " ++ String.fromInt height)
              , semantics
              ]
            , classes |> List.map SvgA.class
            , attributes |> List.map (HtmlA.map never)
            , extraAttributes
            ]
        )
        potentiallyTitledContents


{-| This function exists purely to trigger an error if these two types fall out of sync, as they should be the same.
-}
updateInternalIcon : IconDef -> Internal.IconDef
updateInternalIcon icon =
    icon
