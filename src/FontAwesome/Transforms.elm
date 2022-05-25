module FontAwesome.Transforms exposing
    ( grow, shrink
    , up, down, left, right
    , rotate, flipV, flipH
    , Transform(..), Axis(..)
    )

{-| Provides tools for transforming icons.

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/power-transforms)


# Scaling

@docs grow, shrink


# Positioning

@docs up, down, left, right


# Rotating & Flipping

@docs rotate, flipV, flipH


# Manual

@docs Transform, Axis

-}


{-| Transform the icon by growing it by the given amount. Units are 1/16em.
-}
grow : Float -> Transform
grow =
    Scale


{-| Transform the icon by shrinking it by the given amount. Units are 1/16em.
-}
shrink : Float -> Transform
shrink =
    negate >> Scale


{-| Transform the icon by repositioning it upwards by the given amount. Units are 1/16em.
-}
up : Float -> Transform
up =
    negate >> Reposition Vertical


{-| Transform the icon by repositioning it downwards by the given amount. Units are 1/16em.
-}
down : Float -> Transform
down =
    Reposition Vertical


{-| Transform the icon by repositioning it leftwards by the given amount. Units are 1/16em.
-}
left : Float -> Transform
left =
    negate >> Reposition Horizontal


{-| Transform the icon by repositioning it rightwards by the given amount. Units are 1/16em.
-}
right : Float -> Transform
right =
    Reposition Horizontal


{-| Transform the icon by flipping it on it's horizontal axis.
-}
flipH : Transform
flipH =
    Flip Horizontal


{-| Transform the icon by flipping it on it's vertical axis.
-}
flipV : Transform
flipV =
    Flip Vertical


{-| Transform the icon by rotating it by the given number of degrees clockwise (negateative numbers will produce an
anticlockwise rotation.
-}
rotate : Float -> Transform
rotate =
    Rotate


{-| Transforms that modify an icon.
-}
type Transform
    = Scale Float
    | Reposition Axis Float
    | Rotate Float
    | Flip Axis


{-| An axis.
-}
type Axis
    = Vertical
    | Horizontal
