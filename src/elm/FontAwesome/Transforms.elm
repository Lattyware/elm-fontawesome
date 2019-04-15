module FontAwesome.Transforms exposing
    ( grow, shrink
    , up, down, left, right
    , rotate, flipV, flipH
    , Transform(..), ScaleTransform(..), RepositionTransform(..), Axis(..)
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

@docs Transform, ScaleTransform, RepositionTransform, Axis

-}


{-| Transform the icon by growing it by the given amount. Units are 1/16em.
-}
grow : Float -> Transform
grow by =
    by |> Grow |> Scale


{-| Transform the icon by shrinking it by the given amount. Units are 1/16em.
-}
shrink : Float -> Transform
shrink by =
    by |> Shrink |> Scale


{-| Transform the icon by repositioning it upwards by the given amount. Units are 1/16em.
-}
up : Float -> Transform
up by =
    by |> Up |> Reposition


{-| Transform the icon by repositioning it downwards by the given amount. Units are 1/16em.
-}
down : Float -> Transform
down by =
    by |> Down |> Reposition


{-| Transform the icon by repositioning it leftwards by the given amount. Units are 1/16em.
-}
left : Float -> Transform
left by =
    by |> Left |> Reposition


{-| Transform the icon by repositioning it rightwards by the given amount. Units are 1/16em.
-}
right : Float -> Transform
right by =
    by |> Right |> Reposition


{-| Transform the icon by flipping it on it's horizontal axis.

Note that multiple flips do not cancel each other out. Any number of flips on the same axis will just result in one
flip.

-}
flipH : Transform
flipH =
    Flip Horizontal


{-| Transform the icon by flipping it on it's vertical axis.

Note that multiple flips do not cancel each other out. Any number of flips on the same axis will just result in one
flip.

-}
flipV : Transform
flipV =
    Flip Vertical


{-| Transform the icon by rotating it by the given number of degrees clockwise (negative numbers will produce an
anticlockwise rotation.
-}
rotate : Float -> Transform
rotate by =
    Rotate by


{-| Transforms that modify an icon.
-}
type Transform
    = Scale ScaleTransform
    | Reposition RepositionTransform
    | Rotate Float
    | Flip Axis


{-| Transforms that adjust the scale of an icon.
-}
type ScaleTransform
    = Grow Float
    | Shrink Float


{-| Transforms that adjust the position of an icon.
-}
type RepositionTransform
    = Up Float
    | Down Float
    | Left Float
    | Right Float


{-| An axis for flipping an icon.
-}
type Axis
    = Vertical
    | Horizontal
