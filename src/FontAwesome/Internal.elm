module FontAwesome.Internal exposing
    ( Icon(..)
    , IconDef
    , WithId
    , WithoutId
    , topLevelDimensions
    )

{-| Internal module to avoid a dependency cycle.
-}

import FontAwesome.Transforms exposing (Transform)
import Svg


{-| This must remain the same as the definition for `Icon.IconDef`.
-}
type alias IconDef =
    { prefix : String
    , name : String
    , size : ( Int, Int )
    , paths : ( String, Maybe String )
    }


type WithId
    = WithId


type WithoutId
    = WithoutId


{-| Exposes the constructor here, but shouldn't publicly.
-}
type Icon hasId
    = Icon
        { icon : IconDef
        , transforms : List Transform
        , role : String
        , id : Maybe String
        , title : Maybe String
        , outer : Maybe (Icon WithId)
        , attributes : List (Svg.Attribute Never)
        }


topLevelDimensions : Icon hasId -> ( Int, Int )
topLevelDimensions (Icon { icon, outer }) =
    outer
        |> Maybe.map topLevelDimensionsInternal
        |> Maybe.withDefault icon.size


topLevelDimensionsInternal : Icon hasId -> ( Int, Int )
topLevelDimensionsInternal (Icon { icon, outer }) =
    outer
        |> Maybe.map topLevelDimensions
        |> Maybe.withDefault icon.size
