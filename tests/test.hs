null [1,2,3]

take 1 [3,9,3]
[3]

drop 3 [8,4,2,1,5,6]
[1,5,6]

10 `elem` [3,4,5,6]
False 
permet de vérifier si un élément se trouve dans la liste

create a list from 1 to 20 => [1..20]
you can also specify a step 
[2,4..20]
[2,4,6,8,10,12,14,16,18,20]
pour faire une liste en sens inverse [20,19..1]

liste en compréhension 
[x*2 | x <- [1..10]]
[2,4,6,8,10,12,14,16,18,20]

avec l'ajout d'une condition
[x*2 | x <- [1..10], x*2 >= 12]
[12,14,16,18,20]

[ x | x <- [50..100], x `mod` 7 == 3]
[52,59,66,73,80,87,94]

[ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
[10,11,12,14,16,17,18,20]

[ x*y | x <- [2,5,10], y <- [8,10,11]]
[16,20,22,40,50,55,80,100,110]

[(1, 2), (8, 11, 5), (4, 5)] doesn't work
[(1,2),("One",2)] also doesn't work

you can't compare two tuples of different sizes, whereas you can compare two lists of different sizes.

zip [1,2,3,4,5] [5,5,5,5,5]
[(1,5),(2,5),(3,5),(4,5),(5,5)]
we can zip finite lists with infinite lists

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']] 

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

Note: The x:xs pattern is used a lot, especially with recursive functions.
But patterns that have : in them only match against lists of length 1 or more.
If you want to bind, say, the first three elements to variables and the rest of
the list to another variable, you can use something like x:y:z:zs. It will only
match against lists that have three elements or more.

tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

guards =>
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!


myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT
ghci> 3 `myCompare` 2
GT

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

ghci> [let square x = x * x in (square 5, square 3, square 2)]
[(25,9,4)]

ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
(6000000,"Hey there!")

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]

case expression of pattern -> result
                   pattern -> result
                   pattern -> result
                   ...



