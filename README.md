# Haskell: Hunt the Wumpus Solver

## Description
This program implements an intelligent agent designed to solve the classic game **Hunt the Wumpus**. The agent employs a depth-first search algorithm to navigate through a cave represented as a grid, aiming to find and hunt the Wumpus while avoiding hazards such as pits. The implementation consists of several functions that facilitate the search and pathfinding process.

## Authors
- **Sarah Akhtar**
- **Kieran Monks**

## Date
October 28, 2024

## Game Overview
In **Hunt the Wumpus**, players explore a cave consisting of interconnected rooms, each potentially containing hazards like the Wumpus, giant bats, or bottomless pits. The objective is to locate and kill the Wumpus while avoiding these dangers. Players can move between rooms and shoot arrows to eliminate the Wumpus.

## Functions Overview
The program includes five core functions:

1. **replaceByIndex**: Replaces an element in a list at a specified index.
2. **replaceByIndices**: Replaces an element in a two-dimensional list (grid) at specified row and column indices.
3. **findByIndices**: Retrieves the value from a two-dimensional list at specified row and column indices.
4. **findWumpus**: Initiates the search for the Wumpus starting from a predefined position in the cave.
5. **solver**: Recursively explores the cave, marking visited cells and building the path to the Wumpus.

## Implementation Details

### Main Functions

```haskell
-- Function 1: replaceByIndex
replaceByIndex list index value =
    take index list ++ [value] ++ drop (index + 1) list

-- Function 2: replaceByIndices
replaceByIndices lists row column value =
    take row lists ++ [replaceByIndex (lists !! row) column value] ++ drop (row + 1) lists

-- Function 3: findByIndices
findByIndices lists row column = (lists !! row) !! column
```

### Pathfinding Logic

```haskell
-- Function 4: findWumpus
findWumpus cave = solver cave [['n','n','n','n','n','n'], 
                                ['n','n','n','n','n','n'], 
                                ['n','n','n','n','n','n'], 
                                ['y','n','n','n','n','n']] 3 0 []

where
-- Helper function: solver
solver cave visited row col path =
    if (findByIndices cave row col) == 'W' then path
    else if row > 0 && (findByIndices cave (row - 1) col /= 'P') && 
            (findByIndices visited (row - 1) col /= 'y') then 
        solver cave (replaceByIndices visited row col 'y') (row - 1) col (path ++ "u")
    else if row < 3 && (findByIndices cave (row + 1) col /= 'P') && 
            (findByIndices visited (row + 1) col /= 'y') then 
        solver cave (replaceByIndices visited row col 'y') (row + 1) col (path ++ "d")
    else 
        solver (replaceByIndices cave row col 'P') [['n', 'n', 'n', 'n', 'n', 'n'], 
                                                      ['n', 'n', 'n', 'n', 'n', 'n'], 
                                                      ['n', 'n', 'n', 'n', 'n', 'n'], 
                                                      ['y', 'n', 'n', 'n', 'n', 'n']] 3 0 []
```

### Test Cave Example

```haskell
cave1 = [
    ['O', 'O', 'O', 'O', 'P', 'O'],
    ['O', 'O', 'P', 'W', 'O', 'O'],
    ['O', 'O', 'O', 'P', 'O', 'P'],
    ['O', 'O', 'O', 'O', 'O', 'O']
]

main = do 
    putStrLn("Finding Wumpus: " ++ show(findWumpus cave1))
```

## Running the Program
To run this program, ensure you have a Haskell environment set up. Compile and execute the main function to see the path found by the intelligent agent to hunt the Wumpus.

## Conclusion
This implementation serves as an educational example of how to build an intelligent agent using depth-first search techniques in Haskell. It encapsulates essential programming concepts while providing insight into game mechanics and AI pathfinding strategies.
