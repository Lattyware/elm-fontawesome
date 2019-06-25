module FontAwesome.Transforms.Internal exposing
    ( CombinedTransform
    , SvgTransformStyles
    , baseSize
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


meaninglessTransform : CombinedTransform
meaninglessTransform =
    { size = baseSize
    , x = 0
    , y = 0
    , rotate = 0
    , flipX = False
    , flipY = False
    }


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


combine : List Transform -> CombinedTransform
combine transforms =
    List.foldl add meaninglessTransform transforms


add : Transform -> CombinedTransform -> CombinedTransform
add transform combined =
    case transform of
        Scale direction ->
            let
                amount =
                    case direction of
                        Grow by ->
                            by

                        Shrink by ->
                            -by
            in
            { combined | size = combined.size + amount }

        Reposition direction ->
            let
                ( x, y ) =
                    case direction of
                        Up by ->
                            ( 0, -by )

                        Down by ->
                            ( 0, by )

                        Left by ->
                            ( -by, 0 )

                        Right by ->
                            ( by, 0 )
            in
            { combined | x = combined.x + x, y = combined.y + y }

        Rotate rotation ->
            { combined | rotate = combined.rotate + rotation }

        Flip Vertical ->
            { combined | flipX = True }

        Flip Horizontal ->
            { combined | flipY = True }
