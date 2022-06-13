# FontAwesome for Elm.

[![Generator Build Status](https://img.shields.io/github/workflow/status/lattyware/elm-fontawesome-generator/Build?label=generator%20build&logo=github)](https://github.com/Lattyware/elm-fontawesome-generator/actions/workflows/build.yml)
[![Package Publish Status](https://img.shields.io/github/workflow/status/lattyware/elm-fontawesome/Publish?label=package%20publish&logo=github)](https://github.com/Lattyware/elm-fontawesome/actions/workflows/publish.yml)
[![Elm package](https://img.shields.io/elm-package/v/lattyware/elm-fontawesome?logo=elm)](https://package.elm-lang.org/packages/lattyware/elm-fontawesome/latest/)
[![FontAwesome version](https://img.shields.io/github/package-json/dependency-version/lattyware/elm-fontawesome-generator/@fortawesome/fontawesome-svg-core?label=FontAwesome&logo=fontawesome)](https://github.com/Lattyware/elm-fontawesome-generator/blob/main/package.json)

This is an Elm library for [FontAwesome][fa]. This does not rely on any
external javascript (e.g: using the JavaScript library to replace nodes, which
can cause issues with Elm), and unlike the font, only includes the icons you
use in your Elm code if you minify your output, as well as providing access to
the powerful transformation, layering, text, counter, and masking features.

[fa]: https://fontawesome.com/

## How it works.

This package is generated using [the FontAwesome SVG JavaScript Core][fa-core].
If you are interested in how this is done, would like to manually subset the
icons (which shouldn't be necessary due to tree-shaking in most cases), or want
to update to a new version of FontAwesome (do also feel free to submit an issue
if the library is out of date) please see [the generator
repo][elm-fontawesome-generator].

This does mean that this is a big package, the compiled Elm code weighs in at
over 1MB. This would naturally not be ideal in most situations. The good news
is that it is easy to minify out any unused icons thanks to Elm's pure nature.
If you are already minifying your compiled Elm (which is good practice anyway),
then you don't need to do anything more. If you are not, then [it is simple to
do][minification]. This will result in perfect subsetting - you only ship the
icons you use.

[fa-core]: https://fontawesome.com/how-to-use/on-the-web/advanced/svg-javascript-core
[elm-fontawesome-generator]: https://github.com/Lattyware/elm-fontawesome-generator
[minification]: https://guide.elm-lang.org/optimization/asset_size.html

## Using the elm library.

The easiest way to use the library is to install the elm package directly:
`elm install lattyware/elm-fontawesome`.

Once you have done that, the best place to start is at [the
`elm-fontawesome-example` project][elm-fontawesome-example] which should give
you a good idea of what you can do and how to do it. For more detail on the
available options, please see [the documentation][docs], which gives an
exhaustive description.

[elm-fontawesome-example]: https://github.com/Lattyware/elm-fontawesome-example
[docs]: https://package.elm-lang.org/packages/lattyware/elm-fontawesome/latest/

### Function names.

In general, names are just the camel-cased version of the original name. E.g: `arrow-alt-circle-right` becomes `FontAwesome.Solid.arrowAltCircleRight`. Where
the first character of the name isn't valid as an Elm identifier, the name is
prefixed with `fa`, e.g: `500px` becomes `FontAwesome.Brands.fa500px`. Note
this applies to the `FontAwesome.Attributes` module as well, so `2x` becomes
`FontAwesome.Attributes.fa2x`.

### Required CSS.

FontAwesome does require some CSS styles. You can either use
`FontAwesome.Styles.css` to include an HTML `style` node with the necessary
code directly in your page in Elm, or you can include the CSS from
`@fortawesome/fontawesome-svg-core/styles.css` in your page however
you choose. Do note you do _not_ need the webfont version - the icons in this
package are rendered with SVG, and while that CSS will work, you will make your
users load a webfont for no reason.

### Styling icons.

Font Awesome supports [styling your icons][styling] in various ways. These
styles are exposed as attributes for the various classes in the
`FontAwesome.Attributes` module.

[styling]: https://fontawesome.com/how-to-use/on-the-web/styling

## Differences in behaviour from the official library.

While effort has been made to produce the same output where possible, some
differences from the official library do exist:

- We don't produce or consume any `data` attributes as we won't use them from
  Elm code anyway.
- When masks are created, the official library generates random ids to avoid
  collisions from multiple icons on the same page. In Elm, this is impossible
  to do without exposing it in the API, so we don't. If you need ids you will
  need to manually specify them. It is possible to generate and use random ids,
  but that requires more effort in Elm, please see [the example][random-ids]
  for more.

[random-ids]: https://github.com/Lattyware/elm-fontawesome-example/blob/main/src/RandomIds.elm

## Troubleshooting.

### Icons show up as giant images.

This normally means you have not [included the required CSS](#required-css).

### My class isn't applied, or it is but the icon breaks.

Mixing `Svg.Attribute.class` and `Html.Attribute.class` can cause the classes
to get overwritten. This library uses `Svg.Attribute.class`, so if you always
use this when providing attributes to the library you should not have problems.
