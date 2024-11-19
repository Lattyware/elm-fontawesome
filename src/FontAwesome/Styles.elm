module FontAwesome.Styles exposing (css)

{-| Helpers for adding the CSS required for FontAwesome to your page.

@docs css

-}

import Html exposing (Html)


{-| Generates the accompanying CSS that is necessary to correctly display icons.
-}
css : Html msg
css =
    Html.node "style" [] [ Html.text ":root, :host {  --fa-font-solid: normal 900 1em/1 \"Font Awesome 6 Free\";  --fa-font-regular: normal 400 1em/1 \"Font Awesome 6 Free\";  --fa-font-light: normal 300 1em/1 \"Font Awesome 6 Pro\";  --fa-font-thin: normal 100 1em/1 \"Font Awesome 6 Pro\";  --fa-font-duotone: normal 900 1em/1 \"Font Awesome 6 Duotone\";  --fa-font-duotone-regular: normal 400 1em/1 \"Font Awesome 6 Duotone\";  --fa-font-duotone-light: normal 300 1em/1 \"Font Awesome 6 Duotone\";  --fa-font-duotone-thin: normal 100 1em/1 \"Font Awesome 6 Duotone\";  --fa-font-brands: normal 400 1em/1 \"Font Awesome 6 Brands\";  --fa-font-sharp-solid: normal 900 1em/1 \"Font Awesome 6 Sharp\";  --fa-font-sharp-regular: normal 400 1em/1 \"Font Awesome 6 Sharp\";  --fa-font-sharp-light: normal 300 1em/1 \"Font Awesome 6 Sharp\";  --fa-font-sharp-thin: normal 100 1em/1 \"Font Awesome 6 Sharp\";  --fa-font-sharp-duotone-solid: normal 900 1em/1 \"Font Awesome 6 Sharp Duotone\";  --fa-font-sharp-duotone-regular: normal 400 1em/1 \"Font Awesome 6 Sharp Duotone\";  --fa-font-sharp-duotone-light: normal 300 1em/1 \"Font Awesome 6 Sharp Duotone\";  --fa-font-sharp-duotone-thin: normal 100 1em/1 \"Font Awesome 6 Sharp Duotone\";}svg:not(:root).svg-inline--fa, svg:not(:host).svg-inline--fa {  overflow: visible;  box-sizing: content-box;}.svg-inline--fa {  display: var(--fa-display, inline-block);  height: 1em;  overflow: visible;  vertical-align: -0.125em;}.svg-inline--fa.fa-2xs {  vertical-align: 0.1em;}.svg-inline--fa.fa-xs {  vertical-align: 0em;}.svg-inline--fa.fa-sm {  vertical-align: -0.0714285705em;}.svg-inline--fa.fa-lg {  vertical-align: -0.2em;}.svg-inline--fa.fa-xl {  vertical-align: -0.25em;}.svg-inline--fa.fa-2xl {  vertical-align: -0.3125em;}.svg-inline--fa.fa-pull-left {  margin-right: var(--fa-pull-margin, 0.3em);  width: auto;}.svg-inline--fa.fa-pull-right {  margin-left: var(--fa-pull-margin, 0.3em);  width: auto;}.svg-inline--fa.fa-li {  width: var(--fa-li-width, 2em);  top: 0.25em;}.svg-inline--fa.fa-fw {  width: var(--fa-fw-width, 1.25em);}.fa-layers svg.svg-inline--fa {  bottom: 0;  left: 0;  margin: auto;  position: absolute;  right: 0;  top: 0;}.fa-layers-counter, .fa-layers-text {  display: inline-block;  position: absolute;  text-align: center;}.fa-layers {  display: inline-block;  height: 1em;  position: relative;  text-align: center;  vertical-align: -0.125em;  width: 1em;}.fa-layers svg.svg-inline--fa {  transform-origin: center center;}.fa-layers-text {  left: 50%;  top: 50%;  transform: translate(-50%, -50%);  transform-origin: center center;}.fa-layers-counter {  background-color: var(--fa-counter-background-color, #ff253a);  border-radius: var(--fa-counter-border-radius, 1em);  box-sizing: border-box;  color: var(--fa-inverse, #fff);  line-height: var(--fa-counter-line-height, 1);  max-width: var(--fa-counter-max-width, 5em);  min-width: var(--fa-counter-min-width, 1.5em);  overflow: hidden;  padding: var(--fa-counter-padding, 0.25em 0.5em);  right: var(--fa-right, 0);  text-overflow: ellipsis;  top: var(--fa-top, 0);  transform: scale(var(--fa-counter-scale, 0.25));  transform-origin: top right;}.fa-layers-bottom-right {  bottom: var(--fa-bottom, 0);  right: var(--fa-right, 0);  top: auto;  transform: scale(var(--fa-layers-scale, 0.25));  transform-origin: bottom right;}.fa-layers-bottom-left {  bottom: var(--fa-bottom, 0);  left: var(--fa-left, 0);  right: auto;  top: auto;  transform: scale(var(--fa-layers-scale, 0.25));  transform-origin: bottom left;}.fa-layers-top-right {  top: var(--fa-top, 0);  right: var(--fa-right, 0);  transform: scale(var(--fa-layers-scale, 0.25));  transform-origin: top right;}.fa-layers-top-left {  left: var(--fa-left, 0);  right: auto;  top: var(--fa-top, 0);  transform: scale(var(--fa-layers-scale, 0.25));  transform-origin: top left;}.fa-1x {  font-size: 1em;}.fa-2x {  font-size: 2em;}.fa-3x {  font-size: 3em;}.fa-4x {  font-size: 4em;}.fa-5x {  font-size: 5em;}.fa-6x {  font-size: 6em;}.fa-7x {  font-size: 7em;}.fa-8x {  font-size: 8em;}.fa-9x {  font-size: 9em;}.fa-10x {  font-size: 10em;}.fa-2xs {  font-size: 0.625em;  line-height: 0.1em;  vertical-align: 0.225em;}.fa-xs {  font-size: 0.75em;  line-height: 0.0833333337em;  vertical-align: 0.125em;}.fa-sm {  font-size: 0.875em;  line-height: 0.0714285718em;  vertical-align: 0.0535714295em;}.fa-lg {  font-size: 1.25em;  line-height: 0.05em;  vertical-align: -0.075em;}.fa-xl {  font-size: 1.5em;  line-height: 0.0416666682em;  vertical-align: -0.125em;}.fa-2xl {  font-size: 2em;  line-height: 0.03125em;  vertical-align: -0.1875em;}.fa-fw {  text-align: center;  width: 1.25em;}.fa-ul {  list-style-type: none;  margin-left: var(--fa-li-margin, 2.5em);  padding-left: 0;}.fa-ul > li {  position: relative;}.fa-li {  left: calc(-1 * var(--fa-li-width, 2em));  position: absolute;  text-align: center;  width: var(--fa-li-width, 2em);  line-height: inherit;}.fa-border {  border-color: var(--fa-border-color, #eee);  border-radius: var(--fa-border-radius, 0.1em);  border-style: var(--fa-border-style, solid);  border-width: var(--fa-border-width, 0.08em);  padding: var(--fa-border-padding, 0.2em 0.25em 0.15em);}.fa-pull-left {  float: left;  margin-right: var(--fa-pull-margin, 0.3em);}.fa-pull-right {  float: right;  margin-left: var(--fa-pull-margin, 0.3em);}.fa-beat {  animation-name: fa-beat;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, ease-in-out);}.fa-bounce {  animation-name: fa-bounce;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.28, 0.84, 0.42, 1));}.fa-fade {  animation-name: fa-fade;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));}.fa-beat-fade {  animation-name: fa-beat-fade;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, cubic-bezier(0.4, 0, 0.6, 1));}.fa-flip {  animation-name: fa-flip;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, ease-in-out);}.fa-shake {  animation-name: fa-shake;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, linear);}.fa-spin {  animation-name: fa-spin;  animation-delay: var(--fa-animation-delay, 0s);  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 2s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, linear);}.fa-spin-reverse {  --fa-animation-direction: reverse;}.fa-pulse,.fa-spin-pulse {  animation-name: fa-spin;  animation-direction: var(--fa-animation-direction, normal);  animation-duration: var(--fa-animation-duration, 1s);  animation-iteration-count: var(--fa-animation-iteration-count, infinite);  animation-timing-function: var(--fa-animation-timing, steps(8));}@media (prefers-reduced-motion: reduce) {  .fa-beat,.fa-bounce,.fa-fade,.fa-beat-fade,.fa-flip,.fa-pulse,.fa-shake,.fa-spin,.fa-spin-pulse {    animation-delay: -1ms;    animation-duration: 1ms;    animation-iteration-count: 1;    transition-delay: 0s;    transition-duration: 0s;  }}@keyframes fa-beat {  0%, 90% {    transform: scale(1);  }  45% {    transform: scale(var(--fa-beat-scale, 1.25));  }}@keyframes fa-bounce {  0% {    transform: scale(1, 1) translateY(0);  }  10% {    transform: scale(var(--fa-bounce-start-scale-x, 1.1), var(--fa-bounce-start-scale-y, 0.9)) translateY(0);  }  30% {    transform: scale(var(--fa-bounce-jump-scale-x, 0.9), var(--fa-bounce-jump-scale-y, 1.1)) translateY(var(--fa-bounce-height, -0.5em));  }  50% {    transform: scale(var(--fa-bounce-land-scale-x, 1.05), var(--fa-bounce-land-scale-y, 0.95)) translateY(0);  }  57% {    transform: scale(1, 1) translateY(var(--fa-bounce-rebound, -0.125em));  }  64% {    transform: scale(1, 1) translateY(0);  }  100% {    transform: scale(1, 1) translateY(0);  }}@keyframes fa-fade {  50% {    opacity: var(--fa-fade-opacity, 0.4);  }}@keyframes fa-beat-fade {  0%, 100% {    opacity: var(--fa-beat-fade-opacity, 0.4);    transform: scale(1);  }  50% {    opacity: 1;    transform: scale(var(--fa-beat-fade-scale, 1.125));  }}@keyframes fa-flip {  50% {    transform: rotate3d(var(--fa-flip-x, 0), var(--fa-flip-y, 1), var(--fa-flip-z, 0), var(--fa-flip-angle, -180deg));  }}@keyframes fa-shake {  0% {    transform: rotate(-15deg);  }  4% {    transform: rotate(15deg);  }  8%, 24% {    transform: rotate(-18deg);  }  12%, 28% {    transform: rotate(18deg);  }  16% {    transform: rotate(-22deg);  }  20% {    transform: rotate(22deg);  }  32% {    transform: rotate(-12deg);  }  36% {    transform: rotate(12deg);  }  40%, 100% {    transform: rotate(0deg);  }}@keyframes fa-spin {  0% {    transform: rotate(0deg);  }  100% {    transform: rotate(360deg);  }}.fa-rotate-90 {  transform: rotate(90deg);}.fa-rotate-180 {  transform: rotate(180deg);}.fa-rotate-270 {  transform: rotate(270deg);}.fa-flip-horizontal {  transform: scale(-1, 1);}.fa-flip-vertical {  transform: scale(1, -1);}.fa-flip-both,.fa-flip-horizontal.fa-flip-vertical {  transform: scale(-1, -1);}.fa-rotate-by {  transform: rotate(var(--fa-rotate-angle, 0));}.fa-stack {  display: inline-block;  vertical-align: middle;  height: 2em;  position: relative;  width: 2.5em;}.fa-stack-1x,.fa-stack-2x {  bottom: 0;  left: 0;  margin: auto;  position: absolute;  right: 0;  top: 0;  z-index: var(--fa-stack-z-index, auto);}.svg-inline--fa.fa-stack-1x {  height: 1em;  width: 1.25em;}.svg-inline--fa.fa-stack-2x {  height: 2em;  width: 2.5em;}.fa-inverse {  color: var(--fa-inverse, #fff);}.sr-only,.fa-sr-only {  position: absolute;  width: 1px;  height: 1px;  padding: 0;  margin: -1px;  overflow: hidden;  clip: rect(0, 0, 0, 0);  white-space: nowrap;  border-width: 0;}.sr-only-focusable:not(:focus),.fa-sr-only-focusable:not(:focus) {  position: absolute;  width: 1px;  height: 1px;  padding: 0;  margin: -1px;  overflow: hidden;  clip: rect(0, 0, 0, 0);  white-space: nowrap;  border-width: 0;}.svg-inline--fa .fa-primary {  fill: var(--fa-primary-color, currentColor);  opacity: var(--fa-primary-opacity, 1);}.svg-inline--fa .fa-secondary {  fill: var(--fa-secondary-color, currentColor);  opacity: var(--fa-secondary-opacity, 0.4);}.svg-inline--fa.fa-swap-opacity .fa-primary {  opacity: var(--fa-secondary-opacity, 0.4);}.svg-inline--fa.fa-swap-opacity .fa-secondary {  opacity: var(--fa-primary-opacity, 1);}.svg-inline--fa mask .fa-primary,.svg-inline--fa mask .fa-secondary {  fill: black;}" ]
