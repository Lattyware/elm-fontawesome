module FontAwesome.Attributes exposing
    ( xs, sm, lg, fa2x, fa3x, fa5x, fa7x, fa10x
    , fw
    , ul, li
    , rotate90, rotate180, rotate270, flipHorizontal, flipVertical
    , spin, pulse
    , pullLeft, pullRight, border
    , stack, stack1x, stack2x, inverse
    )

{-| Styling attributes for icons.


# Sizing Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/sizing-icons)

@docs xs, sm, lg, fa2x, fa3x, fa5x, fa7x, fa10x


# Fixed Width Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/fixed-width-icons)

@docs fw


# Icons in a List

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/icons-in-a-list)

@docs ul, li


# Rotating Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/rotating-icons)

@docs rotate90, rotate180, rotate270, flipHorizontal, flipVertical


# Animating Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/animating-icons)

@docs spin, pulse


# Bordered + Pulled Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/bordered-pulled-icons)

@docs pullLeft, pullRight, border


# Stacked Icons

[See the FontAwesome docs for details.](https://fontawesome.com/how-to-use/on-the-web/styling/stacking-icons)

@docs stack, stack1x, stack2x, inverse

-}

import Svg
import Svg.Attributes as SvgA


{-| Apply the `xs` class to the element.
-}
xs : Svg.Attribute msg
xs =
    SvgA.class "xs"


{-| Apply the `sm` class to the element.
-}
sm : Svg.Attribute msg
sm =
    SvgA.class "sm"


{-| Apply the `lg` class to the element.
-}
lg : Svg.Attribute msg
lg =
    SvgA.class "lg"


{-| Apply the `2x` class to the element.
-}
fa2x : Svg.Attribute msg
fa2x =
    SvgA.class "2x"


{-| Apply the `3x` class to the element.
-}
fa3x : Svg.Attribute msg
fa3x =
    SvgA.class "3x"


{-| Apply the `5x` class to the element.
-}
fa5x : Svg.Attribute msg
fa5x =
    SvgA.class "5x"


{-| Apply the `7x` class to the element.
-}
fa7x : Svg.Attribute msg
fa7x =
    SvgA.class "7x"


{-| Apply the `10x` class to the element.
-}
fa10x : Svg.Attribute msg
fa10x =
    SvgA.class "10x"


{-| Apply the `fw` class to the element.
-}
fw : Svg.Attribute msg
fw =
    SvgA.class "fw"


{-| Apply the `ul` class to the element.
-}
ul : Svg.Attribute msg
ul =
    SvgA.class "ul"


{-| Apply the `li` class to the element.
-}
li : Svg.Attribute msg
li =
    SvgA.class "li"


{-| Apply the `rotate-90` class to the element.
-}
rotate90 : Svg.Attribute msg
rotate90 =
    SvgA.class "rotate-90"


{-| Apply the `rotate-180` class to the element.
-}
rotate180 : Svg.Attribute msg
rotate180 =
    SvgA.class "rotate-180"


{-| Apply the `rotate-270` class to the element.
-}
rotate270 : Svg.Attribute msg
rotate270 =
    SvgA.class "rotate-270"


{-| Apply the `flip-horizontal` class to the element.
-}
flipHorizontal : Svg.Attribute msg
flipHorizontal =
    SvgA.class "flip-horizontal"


{-| Apply the `flip-vertical` class to the element.
-}
flipVertical : Svg.Attribute msg
flipVertical =
    SvgA.class "flip-vertical"


{-| Apply the `spin` class to the element.
-}
spin : Svg.Attribute msg
spin =
    SvgA.class "spin"


{-| Apply the `pulse` class to the element.
-}
pulse : Svg.Attribute msg
pulse =
    SvgA.class "pulse"


{-| Apply the `pull-left` class to the element.
-}
pullLeft : Svg.Attribute msg
pullLeft =
    SvgA.class "pull-left"


{-| Apply the `pull-right` class to the element.
-}
pullRight : Svg.Attribute msg
pullRight =
    SvgA.class "pull-right"


{-| Apply the `border` class to the element.
-}
border : Svg.Attribute msg
border =
    SvgA.class "border"


{-| Apply the `stack` class to the element.
-}
stack : Svg.Attribute msg
stack =
    SvgA.class "stack"


{-| Apply the `stack-1x` class to the element.
-}
stack1x : Svg.Attribute msg
stack1x =
    SvgA.class "stack-1x"


{-| Apply the `stack-2x` class to the element.
-}
stack2x : Svg.Attribute msg
stack2x =
    SvgA.class "stack-2x"


{-| Apply the `inverse` class to the element.
-}
inverse : Svg.Attribute msg
inverse =
    SvgA.class "inverse"
