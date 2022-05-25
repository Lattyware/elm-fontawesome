module RandomIds exposing (randomId)

import Random


{-| This is a generator for a random id usable by the library.

See the documentation in [the `elm/random` library](https://package.elm-lang.org/packages/elm/random/latest/) for more
on how to use a generator to get values.

Most of the time, it is easier in Elm to just get a suitable id from your model, but if you don't have a good source for
an id, this gives you a solution.

-}
randomId : Random.Generator String
randomId =
    let
        randomIdChar =
            Random.uniform '0' ("123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.toList)
    in
    Random.map String.fromList (Random.list 12 randomIdChar)
