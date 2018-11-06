# FontAwesome 5 for Elm.

This is a package that generates Elm code for [FontAwesome 5][fa]. This does not rely on any external 
javascript (e.g: using the JavaScript library to replace nodes, which can cause issues with Elm), and unlike the font, 
only includes the icons you use in your Elm code if you minify your output.

[fa]: https://fontawesome.com/

## How it works.

This package works by generating Elm source code using [the FontAwesome SVG JavaScript Core][fa-core].

We load icon packs, then generate Elm functions for each icon. When run, these generate the desired SVG icons. This 
means no need to rely on any external resources - all the data for the icons and supporting styles is encoded into 
the Elm package.

This does mean that this is a big package, the compiled Elm code weighs in at over 1MB. This would naturally not be 
ideal in most situations. The good news is that it is easy to minify out any unused icons thanks to Elm's pure nature.
If you are already minifying your compiled Elm (which is good practice anyway), then you don't need to do anything 
more. If you are not, then [it is simple to do][minification].

[fa-core]: https://fontawesome.com/how-to-use/on-the-web/advanced/svg-javascript-core
[minification]: https://guide.elm-lang.org/optimization/asset_size.html

## Using the elm library.

To start working with the free version, you can install the package directly with `elm install lattyware/elm-fontawesome`.

If you want to use pro icons, you will need to [build the elm package yourself](#building-the-elm-library), as you will 
need access to the pro NPM packages.

Icons are provided as functions in the form `icon : List (Svg.Attribute msg) -> Html msg`, and will result in an `svg` 
node. Do note that `Svg.Attribute` and `Html.Attribute` are really both just `VirtualDom.Attribute`, so you can use 
either.

General use probably looks something like:

```elm
import Html exposing (Html)
import Html.Attributes as HtmlA
import FontAwesome.Solid as Icon
import FontAwesome.Attributes as Icon

view : Html msg
view = 
    Html.div [] [ Icon.arrowAltCircleRight [], Html.text "Go!" ]
    
loadingMessage : Html msg
loadingMessage =
    Html.div [] [ Icon.spinner [ Icon.spin ], Html.text "Loading..." ]
    
noPhotography : Html msg
noPhotography =
    Html.span [ Icon.stack, Icon.fa2x ] 
        [ Icon.camera [ Icon.stack1x ]
        , Icon.ban [ Icon.stack2x, HtmlA.style "color" "Tomato" ]
        ]
```

[See this example on Ellie][ellie]

[ellie]: https://ellie-app.com/3Pg55rczqwZa1

### Function names.

In general, names are just the camel-cased version of the original name. E.g: `arrow-alt-circle-right` becomes 
`FontAwesome.Solid.arrowAltCircleRight`. Where the first character of the name isn't valid as an Elm identifier, the 
name is prefixed with `fa`, e.g: `500px` becomes `FontAwesome.Brands.fa500px`. Note this applies to the 
`FontAwesome.Attributes` module as well, so `2x` becomes `FontAwesome.Attributes.fa2x`. 

### Required CSS.

FontAwesome does require some CSS styles. You can either use `FontAwesome.Styles.css` to include an HTML `style` node 
with the necessary code directly in your page in Elm, or you can include the CSS from 
`@fortawesome/fontawesome-free/css/svg-with-js.min.css` in your page however you choose. Do note you do *not* need the 
webfont version - the icons in this package are rendered with SVG, and while that CSS will work, you will make your 
users load a webfont for no reason.

### Styleing icons.

Font Awesome supports [styling your icons][styling] in various ways. These styles are exposed as attributes for the 
various classes in the `FontAwesome.Attributes` module.

[styling]: https://fontawesome.com/how-to-use/on-the-web/styling

## Building the elm library.

To build the elm package, you will need to first make sure you have the icon packages you want installed.
The possible packages are included as optional dependencies on the node module. For pro icons you will need to have the 
[Fort Awesome Pro NPM registry][pro-npm] configured.
The build will ignore any missing packages and just not produce the relevant modules. While you could use this to 
subset the library, In general, this is unnecessary, as [tree-shaking][minification] achieves the same (and often 
better) results more easily.

Then run `npm build` or for the free version `npm build-pro` for the pro version. The resulting elm library will be 
output in `dist`. Unfortunately there is no nice way to work with local packages in Elm as of the time of writing, so
you will need to copy the source into your application or use an alternative system.

[pro-npm]: https://fontawesome.com/how-to-use/on-the-web/setup/using-package-managers#installing-pro
