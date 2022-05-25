module FontAwesome.Transforms.Internal exposing
    ( CombinedTransform
    , SvgTransformStyles
    , baseSize
    , combine
    , meaningfulTransform
    , meaninglessTransform
    , transformForSvg
    )

import FontAwesome.Transforms exposing (..)
import Svg exposing (Svg)
import Svg.Attributes as SvgA


baseSize : Float
baseSize =
    16


type alias CombinedTransform =
    { size : Float
    , x : Float
    , y : Float
    , rotate : Float
    , flipX : Bool
    , flipY : Bool
    }


type alias SvgTransformStyles msg =
    { outer : Svg.Attribute msg
    , inner : Svg.Attribute msg
    , path : Svg.Attribute msg
    }


meaninglessTransform : CombinedTransform
meaninglessTransform =
    { size = baseSize
    , x = 0
    , y = 0
    , rotate = 0
    , flipX = False
    , flipY = False
    }


combine : List Transform -> CombinedTransform
combine transforms =
    List.foldl add meaninglessTransform transforms


meaningfulTransform : List Transform -> Maybe CombinedTransform
meaningfulTransform transforms =
    let
        combined =
            combine transforms
    in
    if combined == meaninglessTransform then
        Nothing

    else
        Just combined


transformForSvg : Int -> Int -> CombinedTransform -> SvgTransformStyles msg
transformForSvg containerWidth iconWidth transform =
    let
        outer =
            "translate(" ++ String.fromFloat (toFloat containerWidth / 2) ++ " 256)"

        innerTranslate =
            "translate(" ++ String.fromFloat (transform.x * 32) ++ "," ++ String.fromFloat (transform.y * 32) ++ ") "

        flipX =
            if transform.flipX then
                -1

            else
                1

        flipY =
            if transform.flipY then
                -1

            else
                1

        scaleX =
            transform.size / baseSize * flipX

        scaleY =
            transform.size / baseSize * flipY

        innerScale =
            "scale(" ++ String.fromFloat scaleX ++ ", " ++ String.fromFloat scaleY ++ ") "

        innerRotate =
            "rotate(" ++ String.fromFloat transform.rotate ++ " 0 0)"

        path =
            "translate(" ++ String.fromFloat (toFloat iconWidth / 2 * -1) ++ " -256)"
    in
    { outer = outer |> SvgA.transform
    , inner = innerTranslate ++ innerScale ++ innerRotate |> SvgA.transform
    , path = path |> SvgA.transform
    }



{- Private -}


add : Transform -> CombinedTransform -> CombinedTransform
add transform combined =
    case transform of
        Scale by ->
            { combined | size = combined.size + by }

        Reposition axis by ->
            let
                ( x, y ) =
                    case axis of
                        Vertical ->
                            ( 0, by )

                        Horizontal ->
                            ( by, 0 )
            in
            { combined | x = combined.x + x, y = combined.y + y }

        Rotate rotation ->
            { combined | rotate = combined.rotate + rotation }

        Flip axis ->
            case axis of
                Vertical ->
                    { combined | flipY = not combined.flipY }

                Horizontal ->
                    { combined | flipX = not combined.flipX }
