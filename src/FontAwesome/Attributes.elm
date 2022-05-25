module FontAwesome.Attributes exposing
    ( fa2xs, xs, sm, lg, x1, fa2x1, fa1x, fa2x, fa3x, fa4x, fa5x, fa6x, fa7x, fa8x, fa9x, fa10x
    , fw
    , ul, li
    , rotate90, rotate180, rotate270, flipHorizontal, flipVertical, flipBoth, flipRotateBy
    , beat, fade, beatFade, bounce, flip, shake, spin, spinPulse, spinReverse
    , pullLeft, pullRight, border
    , stack, stack1x, stack2x, inverse
    , swapOpacity
    )

{-| Styling attributes for icons.


# Sizing Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/size)

@docs fa2xs, xs, sm, lg, x1, fa2x1, fa1x, fa2x, fa3x, fa4x, fa5x, fa6x, fa7x, fa8x, fa9x, fa10x


# Fixed Width Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/fixed-width)

@docs fw


# Icons in a List

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/lists)

@docs ul, li


# Rotating Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/rotate)

@docs rotate90, rotate180, rotate270, flipHorizontal, flipVertical, flipBoth, flipRotateBy


# Animating Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/animate)

@docs beat, fade, beatFade, bounce, flip, shake, spin, spinPulse, spinReverse


# Bordered + Pulled Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/pull)

@docs pullLeft, pullRight, border


# Stacked Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/stacking-icons)

@docs stack, stack1x, stack2x, inverse


# Duotone Icons

[See the FontAwesome docs for details.](https://fontawesome.com/docs/web/style/duotone-icons)

@docs swapOpacity

-}

import Svg
import Svg.Attributes as SvgA


{-| Apply the fa-2xs class to the element.
-}
fa2xs : Svg.Attribute msg
fa2xs =
    SvgA.class "fa-2xs"


{-| Apply the fa-xs class to the element.
-}
xs : Svg.Attribute msg
xs =
    SvgA.class "fa-xs"


{-| Apply the fa-sm class to the element.
-}
sm : Svg.Attribute msg
sm =
    SvgA.class "fa-sm"


{-| Apply the fa-lg class to the element.
-}
lg : Svg.Attribute msg
lg =
    SvgA.class "fa-lg"


{-| Apply the fa-x1 class to the element.
-}
x1 : Svg.Attribute msg
x1 =
    SvgA.class "fa-x1"


{-| Apply the fa-2x1 class to the element.
-}
fa2x1 : Svg.Attribute msg
fa2x1 =
    SvgA.class "fa-2x1"


{-| Apply the fa-1x class to the element.
-}
fa1x : Svg.Attribute msg
fa1x =
    SvgA.class "fa-1x"


{-| Apply the fa-2x class to the element.
-}
fa2x : Svg.Attribute msg
fa2x =
    SvgA.class "fa-2x"


{-| Apply the fa-3x class to the element.
-}
fa3x : Svg.Attribute msg
fa3x =
    SvgA.class "fa-3x"


{-| Apply the fa-4x class to the element.
-}
fa4x : Svg.Attribute msg
fa4x =
    SvgA.class "fa-4x"


{-| Apply the fa-5x class to the element.
-}
fa5x : Svg.Attribute msg
fa5x =
    SvgA.class "fa-5x"


{-| Apply the fa-6x class to the element.
-}
fa6x : Svg.Attribute msg
fa6x =
    SvgA.class "fa-6x"


{-| Apply the fa-7x class to the element.
-}
fa7x : Svg.Attribute msg
fa7x =
    SvgA.class "fa-7x"


{-| Apply the fa-8x class to the element.
-}
fa8x : Svg.Attribute msg
fa8x =
    SvgA.class "fa-8x"


{-| Apply the fa-9x class to the element.
-}
fa9x : Svg.Attribute msg
fa9x =
    SvgA.class "fa-9x"


{-| Apply the fa-10x class to the element.
-}
fa10x : Svg.Attribute msg
fa10x =
    SvgA.class "fa-10x"


{-| Apply the fa-fw class to the element.
-}
fw : Svg.Attribute msg
fw =
    SvgA.class "fa-fw"


{-| Apply the fa-ul class to the element.
-}
ul : Svg.Attribute msg
ul =
    SvgA.class "fa-ul"


{-| Apply the fa-li class to the element.
-}
li : Svg.Attribute msg
li =
    SvgA.class "fa-li"


{-| Apply the fa-rotate-90 class to the element.
-}
rotate90 : Svg.Attribute msg
rotate90 =
    SvgA.class "fa-rotate-90"


{-| Apply the fa-rotate-180 class to the element.
-}
rotate180 : Svg.Attribute msg
rotate180 =
    SvgA.class "fa-rotate-180"


{-| Apply the fa-rotate-270 class to the element.
-}
rotate270 : Svg.Attribute msg
rotate270 =
    SvgA.class "fa-rotate-270"


{-| Apply the fa-flip-horizontal class to the element.
-}
flipHorizontal : Svg.Attribute msg
flipHorizontal =
    SvgA.class "fa-flip-horizontal"


{-| Apply the fa-flip-vertical class to the element.
-}
flipVertical : Svg.Attribute msg
flipVertical =
    SvgA.class "fa-flip-vertical"


{-| Apply the fa-flip-both class to the element.
-}
flipBoth : Svg.Attribute msg
flipBoth =
    SvgA.class "fa-flip-both"


{-| Apply the fa-flip-rotate-by class to the element.
-}
flipRotateBy : Svg.Attribute msg
flipRotateBy =
    SvgA.class "fa-flip-rotate-by"


{-| Apply the fa-beat class to the element.
-}
beat : Svg.Attribute msg
beat =
    SvgA.class "fa-beat"


{-| Apply the fa-fade class to the element.
-}
fade : Svg.Attribute msg
fade =
    SvgA.class "fa-fade"


{-| Apply the fa-beat-fade class to the element.
-}
beatFade : Svg.Attribute msg
beatFade =
    SvgA.class "fa-beat-fade"


{-| Apply the fa-bounce class to the element.
-}
bounce : Svg.Attribute msg
bounce =
    SvgA.class "fa-bounce"


{-| Apply the fa-flip class to the element.
-}
flip : Svg.Attribute msg
flip =
    SvgA.class "fa-flip"


{-| Apply the fa-shake class to the element.
-}
shake : Svg.Attribute msg
shake =
    SvgA.class "fa-shake"


{-| Apply the fa-spin class to the element.
-}
spin : Svg.Attribute msg
spin =
    SvgA.class "fa-spin"


{-| Apply the fa-spin-pulse class to the element.
-}
spinPulse : Svg.Attribute msg
spinPulse =
    SvgA.class "fa-spin-pulse"


{-| Apply the fa-spin-reverse class to the element.
-}
spinReverse : Svg.Attribute msg
spinReverse =
    SvgA.class "fa-spin-reverse"


{-| Apply the fa-pull-left class to the element.
-}
pullLeft : Svg.Attribute msg
pullLeft =
    SvgA.class "fa-pull-left"


{-| Apply the fa-pull-right class to the element.
-}
pullRight : Svg.Attribute msg
pullRight =
    SvgA.class "fa-pull-right"


{-| Apply the fa-border class to the element.
-}
border : Svg.Attribute msg
border =
    SvgA.class "fa-border"


{-| Apply the fa-stack class to the element.
-}
stack : Svg.Attribute msg
stack =
    SvgA.class "fa-stack"


{-| Apply the fa-stack-1x class to the element.
-}
stack1x : Svg.Attribute msg
stack1x =
    SvgA.class "fa-stack-1x"


{-| Apply the fa-stack-2x class to the element.
-}
stack2x : Svg.Attribute msg
stack2x =
    SvgA.class "fa-stack-2x"


{-| Apply the fa-inverse class to the element.
-}
inverse : Svg.Attribute msg
inverse =
    SvgA.class "fa-inverse"


{-| Apply the fa-swap-opacity class to the element.
-}
swapOpacity : Svg.Attribute msg
swapOpacity =
    SvgA.class "fa-swap-opacity"
