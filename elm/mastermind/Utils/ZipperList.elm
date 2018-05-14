module Utils.ZipperList
    exposing
        ( ZipperList
        , init
        , back
        , forward
        , current
        , add
        , update
        , hasPrevious
        , hasNext
        )

{-| This module is designed to provide a simple ZipperList.
Typical usecase is history management


# the `ZipperList` type

@docs ZipperList


# Initializing

@docs init


# Manage

@docs add, update


# Movinf around

@docs current, back, forward


# Checks

@docs hasPrevious, hasNext

-}


{-| ZipperList a record containing three pieces of information:

  - `previous`: contains all previous items
  - `current`: holds the current item
  - `next`: contains all next items

Therefore, the complete list of items is: `previous ++ [current] ++ next`

-}
type alias ZipperList item =
    { previous : List item
    , current : item
    , next : List item
    }


{-| Initializes the `ZipperList`.

Note that `ZipperList` is initialize with an empty `previous` List.


### Arguments

  - `(item)`: The current item

  - `(List item)`: The next items

    init 1 [2, 3, 4, 5] == {previous = [], current = 1, next = [2, 3, 4, 5]}

-}
init : item -> List item -> ZipperList item
init item items =
    ZipperList [] item items


{-| Get one step backward into ZipperList.

If previous list is empty, current item is returned

    --  ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    back ZipperList == {previous = [1], current = 2, next = [3, 4, 5]}

-}
back : ZipperList item -> ZipperList item
back items =
    let
        checkCurrent =
            items.previous
                |> List.reverse
                |> List.head

        newItems =
            case checkCurrent of
                Maybe.Just current ->
                    { items
                        | previous =
                            items.previous
                                |> List.reverse
                                |> List.tail
                                |> toList
                                |> List.reverse
                        , current = current
                        , next = items.current :: items.next
                    }

                Maybe.Nothing ->
                    items
    in
        newItems


{-| Get one step forward into ZipperList.

If next list is empty, current item is returned.

    --  ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    back ZipperList == {previous = [1, 2, 3], current = 4, next = [5]}

-}
forward : ZipperList item -> ZipperList item
forward items =
    let
        checkCurrent =
            List.head items.next

        newItems =
            case checkCurrent of
                Maybe.Just current ->
                    { items
                        | previous = items.previous ++ [ items.current ]
                        , current = current
                        , next =
                            items.next
                                |> List.tail
                                |> toList
                    }

                Maybe.Nothing ->
                    items
    in
        newItems


{-| Return current item

    --  ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    current ZipperList == 3

-}
current : ZipperList item -> item
current items =
    items.current


{-| Add a new items to ZipperList.

Clean `next` list, add the new `item` to it and move ZipperList forward.

This method should be used to rewrite the `next` part of ZipperList while
keeping all `previous` items

    -- ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    add 6 ZipperList == {previous = [1, 2, 3], current = 6, next = []}

-}
add : item -> ZipperList item -> ZipperList item
add item items =
    let
        newItems =
            { items | next = [ item ] }
    in
        newItems |> forward


{-| Update current item.

    -- ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    update 6 ZipperList == {previous = [1, 2], current = 6, next = [4, 5]}

-}
update : item -> ZipperList item -> ZipperList item
update item items =
    { items | current = item }


{-| Determine wether there is any previous items

    -- ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    hasPrevious ZipperList == True

    -- ZipperList2 = {previous = [], current = 1, next = [2, 3, 4, 5]}
    hasPrevious ZipperList2 == False

-}
hasPrevious : ZipperList item -> Bool
hasPrevious items =
    List.length items.previous > 0


{-| Determine wether there is any previous items

    -- ZipperList = {previous = [1, 2], current = 3, next = [4, 5]}
    hasNext ZipperList == True

    -- ZipperList2 = {previous = [1, 2, 3, 4], current = 5, next = []}
    hasPrevious ZipperList2 == False

-}
hasNext : ZipperList item -> Bool
hasNext items =
    List.length items.next > 0


{-| Convert a `Maybe List` to a `List`

    toList (Just [1, 2]) == [1, 2]
    toList Nothing == []

-}
toList : Maybe (List a) -> List a
toList items =
    case items of
        Maybe.Just list ->
            list

        Maybe.Nothing ->
            []
