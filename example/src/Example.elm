module Example exposing (main)

import Browser
import FontAwesome as Icon exposing (Icon)
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Layering as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import FontAwesome.Svg as SvgIcon
import FontAwesome.Transforms as IconT
import Html exposing (Html)
import Html.Attributes as HtmlA
import Random
import RandomIds
import Svg
import Svg.Attributes as SvgA
import Time



-- Simple Examples


simpleExamples =
    -- Some simple examples of rendering icons.
    exampleSection "Simple Examples"
        -- A simple icon can be rendered with Icon.view.
        [ Html.div []
            [ Icon.view Icon.arrowAltCircleRight
            , Html.text " Go!"
            ]

        -- We can apply FontAwesome styles to the icons.
        , Html.div []
            [ Icon.spinner |> Icon.styled [ Icon.spin ] |> Icon.view
            , Html.text " Loading..."
            ]

        -- Including stacking, although take a look further down for layering—it can do the same thing and a lot more!
        , Html.div [ Icon.stack, Icon.fa2x ]
            [ Icon.camera |> Icon.styled [ Icon.stack1x ] |> Icon.view
            , Icon.ban |> Icon.styled [ Icon.stack2x, HtmlA.style "color" "Tomato" ] |> Icon.view
            ]
        ]



-- Sizing Icons


sizes =
    [ Icon.xs, Icon.sm, Icon.lg, Icon.fa2x, Icon.fa3x, Icon.fa5x, Icon.fa7x, Icon.fa10x ]


stroopwafel size =
    Icon.stroopwafel |> Icon.styled [ size ] |> Icon.view


sizingIcons =
    exampleSection "Sizing Icons" (sizes |> List.map stroopwafel)



-- Fixed Width Icons


menuItems =
    [ ( Icon.home, "Home" )
    , ( Icon.info, "Info" )
    , ( Icon.book, "Library" )
    , ( Icon.pencilAlt, "Applications" )
    , ( Icon.cog, "Settings" )
    ]


menuItem ( icon, text ) =
    Html.div []
        [ icon |> Icon.styled [ Icon.fw, HtmlA.style "background" "MistyRose" ] |> Icon.view
        , Html.text " "
        , Html.text text
        ]


fixedWidthIcons =
    exampleSection "Fixed Width Icons"
        [ Html.div [ HtmlA.style "font-size" "2rem" ] (menuItems |> List.map menuItem) ]



-- Icons in a List.


listItems =
    [ ( Icon.checkSquare |> Icon.view, "List icons can" )
    , ( Icon.checkSquare |> Icon.view, "be used to" )
    , ( Icon.spinner |> Icon.styled [ Icon.spinPulse ] |> Icon.view, "replace bullets" )
    , ( Icon.square |> Icon.view, "in lists" )
    ]


listItem ( icon, text ) =
    Html.li [] [ Html.span [ Icon.li ] [ icon ], Html.text text ]


iconsInAList =
    exampleSection "Icons in a List" [ Html.ul [ Icon.ul ] (listItems |> List.map listItem) ]



-- Animating Icons


spinners =
    [ Icon.spinner, Icon.circleNotch, Icon.sync, Icon.cog, Icon.stroopwafel ]


animatingIcons =
    exampleSection "Animating Icons"
        [ Html.div [ Icon.fa3x ]
            [ Icon.spinner |> Icon.styled [ Icon.spinPulse ] |> Icon.view
            , Html.span [] (spinners |> List.map (Icon.styled [ Icon.spin ] >> Icon.view))
            ]
        ]



-- Layering, Text and Counters


layeringTextAndCounters =
    exampleSection "Layering, Text, and Counters"
        [ Html.div [ Icon.fa4x ]
            [ Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.circle |> Icon.view
                , Icon.times |> Icon.styled [ Icon.inverse ] |> Icon.transform [ IconT.shrink 6 ] |> Icon.view
                ]
            , Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.bookmark |> Icon.view
                , Icon.heart
                    |> Icon.styled [ Icon.inverse, HtmlA.style "color" "Tomato" ]
                    |> Icon.transform [ IconT.shrink 10, IconT.up 2 ]
                    |> Icon.view
                ]
            , Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.play |> Icon.transform [ IconT.rotate -90, IconT.grow 2 ] |> Icon.view
                , Icon.sun
                    |> Icon.styled [ Icon.inverse ]
                    |> Icon.transform [ IconT.shrink 10, IconT.up 2 ]
                    |> Icon.view
                , Icon.moon
                    |> Icon.styled [ Icon.inverse ]
                    |> Icon.transform [ IconT.shrink 11, IconT.down 4.2, IconT.left 4 ]
                    |> Icon.view
                , Icon.star
                    |> Icon.styled [ Icon.inverse ]
                    |> Icon.transform [ IconT.shrink 11, IconT.down 4.2, IconT.right 4 ]
                    |> Icon.view
                ]
            , Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.calendar |> Icon.view
                , Icon.textTransformed [ Icon.inverse, HtmlA.style "font-weight" "900" ] [ IconT.shrink 8, IconT.down 3 ] "27"
                ]
            , Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.certificate |> Icon.view
                , Icon.textTransformed [ Icon.inverse, HtmlA.style "font-weight" "900" ] [ IconT.shrink 11.5, IconT.rotate -30 ] "NEW"
                ]
            , Icon.layers [ HtmlA.style "background" "MistyRose" ]
                [ Icon.envelope |> Icon.view
                , Icon.counter [ HtmlA.style "background" "Tomato" ] "1,419"
                ]
            ]
        ]



-- Masking


masking =
    exampleSection "Masking"
        [ Html.div [ Icon.fa4x, HtmlA.style "background" "MistyRose" ]
            [ Icon.pencilAlt
                |> Icon.transform [ IconT.shrink 10, IconT.up 0.5 ]
                |> Icon.masked (Icon.comment |> Icon.withId "comment")
                |> Icon.view
            , Icon.facebookF
                |> Icon.transform [ IconT.shrink 3.5, IconT.down 1.6, IconT.right 1.25 ]
                |> Icon.masked (Icon.circle |> Icon.withId "facebook")
                |> Icon.view
            , Icon.headphones
                |> Icon.transform [ IconT.shrink 6 ]
                |> Icon.masked (Icon.square |> Icon.withId "headphones")
                |> Icon.view
            , Icon.mask
                |> Icon.transform [ IconT.shrink 3, IconT.up 1 ]
                |> Icon.masked (Icon.circle |> Icon.withId "mask")
                |> Icon.view
            ]
        ]



-- Random Ids


randomIdAndIcon =
    Random.map2 (\id -> \icon -> ( id, icon ))
        RandomIds.randomId
        (Random.uniform Icon.car [ Icon.bullhorn, Icon.thumbsUp, Icon.signOutAlt, Icon.clock, Icon.questionCircle, Icon.chessBishop ])


randomise =
    Random.generate Change (Random.list 10 randomIdAndIcon)


randomIconWithId ( id, icon ) =
    icon
        |> Icon.withId id
        |> Icon.titled id
        |> Icon.styled [ Icon.fw ]
        |> Icon.view


randomIds randomIcons =
    exampleSection "Random Ids" (randomIcons |> List.map randomIconWithId)



-- SVG


svgIcons =
    exampleSection "Icons in an existing SVG element."
        [ Svg.svg [ SvgA.viewBox "0 0 512 512", SvgA.style "width: 150px; height: 150px;" ]
            [ SvgIcon.view Icon.pencilAlt ]
        ]


type alias Model =
    List ( String, Icon Icon.WithoutId )


type Msg
    = Randomise
    | Change Model


main : Program () Model Msg
main =
    Browser.document
        { init = always ( [], randomise )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Randomise ->
            ( model, randomise )

        Change newModel ->
            ( newModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 2000 (always Randomise)


view : Model -> Browser.Document Msg
view model =
    { title = "elm-fontawesome Example"
    , body =
        [ Html.div []
            -- First we include the CSS for FontAwesome, so the icons render correctly.
            [ Icon.css
            , Html.h1 [] [ Html.a [ HtmlA.href "https://github.com/Lattyware/elm-fontawesome" ] [ Html.text "elm-fontawesome" ] ]
            , simpleExamples
            , sizingIcons
            , fixedWidthIcons
            , iconsInAList
            , animatingIcons
            , layeringTextAndCounters
            , masking
            , randomIds model
            , svgIcons
            ]
        ]
    }


exampleSection name examples =
    Html.div [] (Html.h2 [] [ Html.text name ] :: examples)
