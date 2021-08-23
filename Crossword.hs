module Crossword where

import System.IO
import Data.List

--Data and Type Values to identify the position of characters and the Direction over the grid

type WordPos = (Int, [(Int, Int)])

data Axis = X | Y
    deriving (Eq, Show)

--Main function to open the txt file and store its values separately, the crossword its solved in fillCrossword and printed in printSolution as IO () 

main :: IO()
main = do
    handle <- openFile "Grid.txt" ReadMode
    contents <- hGetContents handle
    let 
        words = storeWords (last (lines contents))
        crw = pop (lines contents)
        x = fillCrossword (searchSpace crw) words crw 
    print words
    printSolution x
    hClose handle 

--breaks up a string into a list of Strings

storeWords :: String -> [String]
storeWords w = pre : if null suc then [] else storeWords $ tail suc
    where (pre, suc) = break (\x -> x == ';') w

-- pops the last element of a list

pop :: [String] -> [String]
pop [] = []
pop xs = init xs

--prints a list in new lines

printSolution :: [String] -> IO ()
printSolution sol = do
    let s = unlines sol
    putStrLn s

--breaks ups a string and converts it into a list where items from the same group are joined together

stringSeparator :: String -> [String]
stringSeparator s
    | null s  = []
    | otherwise = let
                    h = head s 
                    (eq,lo) = span (==h) s
                  in eq : stringSeparator lo

-- counts the value of an element

count :: Eq a => [a] -> a -> Int
count [] val = 0
count (x:lo) val = if x == val
                   then do 
                       1 + count lo val
                   else do 
                       count lo val

--locates available spaces in a column or a row

spaceLocator :: String -> Int -> Int -> Axis -> [WordPos]
spaceLocator cwInp x y axis
    | null cwInp  = []
    | otherwise = if axis == X
        then 
            let sep = stringSeparator cwInp
                initial = head sep
                val = head initial
                point = [(x'+x,y) | x' <- take (length initial) [0..]]
            in
                if   length initial > 1 && val == '-'  
                then (length initial, point) : spaceLocator (concat (tail sep)) (x+length initial) (y) (X)
                else spaceLocator (concat (tail sep)) (x+length initial) (y) (X)
        else 
            let sep = stringSeparator cwInp
                initial = head sep
                val = head initial
                point = [(x,y+y') | y' <- take (length initial) [0..]]
            in
                if   length initial > 1 && val == '-' 
                then (length initial, point) : spaceLocator (concat (tail sep)) (x) (y+length initial) (Y)
                else spaceLocator (concat (tail sep)) (x) (y+length initial) (Y)

--locates all the available spaces in the grid

searchSpace :: [String] -> [WordPos]
searchSpace cw = let 
                    x = [spaceLocator row 0 y X | (row,y) <- zip cw [0..]]
                    y = [spaceLocator column x 0 Y | (column,x) <- zip (transpose cw) [0..]] 
                    spaces   = concat (x ++ y)
                    len = map (fst) (spaces)
                 in sortBy (\ (x1,_) (x2,_) -> compare (count len x1) (count len x2)) spaces

--indicates if wordPos is horizontal and returns X if it is

isHorizontal :: WordPos -> Axis
isHorizontal pos = let
                pointVal1 = (snd . head . snd) pos
                pointVal2 = snd (snd pos !! 1) 
             in
                if pointVal1 == pointVal2 then X else Y
            
--indicates if a position is available

isAvailable :: String -> [String] -> WordPos -> Bool
isAvailable s cw pos = let
                            point = snd pos
                            len = length s
                          in len == fst pos && and [(cw!!y)!!x == '-' || (cw!!y)!!x == ch | (ch,(x,y)) <- zip s point]

--fills  the spaces vertically or horizontally with the corresponding word

fillWord :: WordPos -> String -> [String] -> [String]
fillWord pos s cw = if isHorizontal (pos) == X
                        then
                            let
                                x = (fst . head . snd) pos
                                y = (snd . head . snd) pos
                                len = fst pos
                                row = cw!!y
                            in take y cw ++ [take x row ++ s ++ drop (x+len) row] ++ drop (y+1) cw
                        else
                            let 
                                x = (fst . head . snd) pos
                                y = (snd . head . snd) pos
                                len = fst pos
                            in take y cw ++ [take x (cw!!y') ++ ((s!!(y'-y)) : drop (x+1) (cw!!y')) | y' <- take len [y..]] ++ drop (y+len) cw

--final function to fill completely the crossword 

fillCrossword :: [WordPos] -> [String] -> [String] -> [String]
fillCrossword pos s cw
    | null s = cw
    | otherwise = let
                      str = head s
                      match = filter (\ ((len,_),_) -> len == length str) (zip pos [0..])
                      writeIn = (\ (slot,x) -> fillCrossword ([slot' | (slot',x') <- zip pos [0..], x' /= x]) (tail s) (fillWord slot str cw) )
                      emptySpaces = map fst $ filter (\ (_,bool) -> bool) $ zip match $ map (isAvailable str cw . fst) match
                  in 
                      concat ( map writeIn emptySpaces)