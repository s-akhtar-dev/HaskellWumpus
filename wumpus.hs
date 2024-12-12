{-|
Description : Intelligent Agent for Solving Hunt the Wumpus
Course : COMP 141 Programming Languages
Authors : Kieran Monks and Sarah Akhtar
Date : October 28th, 2024
This program implements an intelligent system for creating
a route that solves Hunt the Wumpus. The program consists
of five functions (replaceByIndex, replaceByIndices,
findByIndices, solver, and findWumpus) that perform a
depth-first search to attain a route to hunting the wumpus.
-}

-- Function 1: replaceByIndex
replaceByIndex list index value =
take index list ++ [value] ++ drop (index + 1) list

-- Function 2: replaceByIndices
replaceByIndices lists row column value =
take row lists ++ [replaceByIndex (lists !! row) column value]
++ drop (row + 1) lists

-- Function 3: findByIndices
findByIndices lists row column = (lists !! row) !! column

-- Function 4: findWumpus
-- Takes a cave and returns a path to the 'W' aka the Wumpus.
-- The path is a string consisting of moves: 'r' (right), 'l'
(left), 'u' (up), and 'd' (down).
-- The search starts from the position (3, 0) and avoids pits
('P') and already visited cells.
findWumpus cave = solver cave [['n','n','n','n','n','n'], --
Initial visited grid
['n','n','n','n','n','n'], -- 'n'
means not visited
['n','n','n','n','n','n'], -- and
'y' means visited
['y','n','n','n','n','n']] 3 0 []
where
-- Helper function: solver
-- Recursively searches for the 'W' character, updating
visited cells and recording the path.
solver cave visited row col path =
-- Base case:
if
'W' is found,
    return the path.if (findByIndices cave row col) ==
           'W' then path-- Move right if within bounds,
    the cell is not a pit,
    and it hasnt been visited.else if row > 0 &&
        (findByIndices cave(row - 1) col /= 'P') &&
        (findByIndices visited(row - 1) col /= 'y') then solver
        cave(replaceByIndices visited row col 'y')(row - 1)
            col(path++ "u")-- Move left if within bounds,
    the cell is not a pit,
    and it hasnt been visited.else if row < 3 &&
        (findByIndices cave(row + 1) col /= 'P') &&
        (findByIndices visited(row + 1) col /= 'y') then solver
        cave(replaceByIndices visited row col 'y')(row + 1)
            col(path++ "d")-- Dead end : If no valid moves,
    mark the current cell as a pit and restart.else solver(
        replaceByIndices cave row col 'P')[
        [ 'n', 'n', 'n', 'n', 'n', 'n' ], [ 'n', 'n', 'n', 'n', 'n', 'n' ],
        [ 'n', 'n', 'n', 'n', 'n', 'n' ],
        [ 'y', 'n', 'n', 'n', 'n', 'n' ]] 3 0 []-- Test cave cave1 =
        [
          [ 'O', 'O', 'O', 'O', 'P', 'O' ], [ 'O', 'O', 'P', 'W', 'O', 'O' ],
          [ 'O', 'O', 'O', 'P', 'O', 'P' ], [ 'O', 'O', 'O', 'O', 'O', 'O' ]
        ]-- Main function to run the
    findWumpus function on cave1 and display the resulting path main =
        do putStrLn("Finding Wumpus: " ++show(findWumpus cave1))
