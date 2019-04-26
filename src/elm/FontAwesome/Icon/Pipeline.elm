module FontAwesome.Icon.Pipeline exposing
    ( present
    , styled, transform, withId, titled, masked
    , view, viewId
    , Presentation, Anonymous, Identified
    )

{-| Rendering icons for use in HTML.

This module provides a pipeline system that makes it easier to work with the more complex features of the library.

You start your pipeline using `present`.

@docs present

Then you apply any additional presentation details.

@docs styled, transform, withId, titled, masked

Then you render to HTML.

@docs view, viewId

You shouldn't ever need to directly interact with the presentation records.

@docs Presentation, Anonymous, Identified

-}

import FontAwesome.Icon as Icon exposing (Icon)
import FontAwesome.Transforms as Transforms exposing (Transform)
import Html exposing (Html)
import Svg


{-| Render the given presentation to HTML. See `viewId` if your pipeline includes a unique id.
-}
view : Presentation Anonymous msg -> Html msg
view presentation =
    Icon.viewTransformed presentation.attributes presentation.transforms presentation.icon


{-| Render the given presentation to HTML. See `view` if your pipeline doesn't include a unique id.
-}
viewId : Presentation Identified msg -> Html msg
viewId presentation =
    Icon.viewWithId presentation.id presentation.attributes presentation.transforms presentation.title presentation.outer presentation.icon


{-| Get a basic presentation record for the icon. By default, this is considered semantically meaningless (it is just
a decorative element) and will be hidden from accessibility tools.
-}
present : Icon -> Presentation Anonymous msg
present icon =
    { icon = icon
    , attributes = []
    , transforms = []
    }


{-| Set the ID for the presentation record to the given value. This must be unique on the page.
-}
withId : String -> Presentation Anonymous msg -> Presentation Identified msg
withId id presentation =
    { icon = presentation.icon
    , attributes = presentation.attributes
    , transforms = presentation.transforms
    , id = id
    , title = Nothing
    , outer = Nothing
    }


{-| Add the given attributes to the presentation record. These will be applied to the final icon.
-}
styled : List (Svg.Attribute msg) -> Presentation identification msg -> Presentation identification msg
styled attributes presentation =
    { presentation | attributes = presentation.attributes ++ attributes }


{-| Add the given transforms to the presentation record. These will be applied to the final icon.
-}
transform : List Transform -> Presentation identification msg -> Presentation identification msg
transform transforms presentation =
    { presentation | transforms = presentation.transforms ++ transforms }


{-| Sets the title of the presented icon. This will make the icon semantically meaningful, and as such it won't be
hidden from accessibility tools.

Note that this can only be applied where the icon has a unique id. Use `withId` to add one.

-}
titled : String -> Presentation Identified msg -> Presentation Identified msg
titled title presentation =
    { presentation | title = Just title }


{-| Sets an outer icon that the main icon is masking.

Note that this can only be applied where the icon has a unique id. Use `withId` to add one.

-}
masked : Icon -> Presentation Identified msg -> Presentation Identified msg
masked outer presentation =
    { presentation | outer = Just outer }


{-| Details on how to render an icon.
-}
type alias Presentation identification msg =
    { identification
        | icon : Icon
        , attributes : List (Svg.Attribute msg)
        , transforms : List Transform
    }


{-| Presentation details specific to when there is no unique id.
-}
type alias Anonymous =
    {}


{-| Presentation details specific to when there is a unique id.
-}
type alias Identified =
    { id : String
    , title : Maybe String
    , outer : Maybe Icon
    }
