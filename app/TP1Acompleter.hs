import Data.List

{-
-- :r
-- commentaires, multilignes
-}

-- constante entiere, identifiant, declaration typee, definition

c2 :: Int
c2 = 2

c3 :: Int
c3 = 1 - 3 

c4 :: Int
c4 = (-) 1 3

-- mySub 5 3
-- 2
mySub :: Int -> Int -> Int
mySub x y = x - y

-- myNeg 3
-- -3
myNeg :: Int -> Int
--myNeg x = mySub 0 x
myNeg = mySub 0

-- boolean

b1 :: Bool
b1 = (not (True || False)) && True 

b2 :: Bool
b2 = 1 >= 2

b3 :: Bool
b3 = 1 /= 2

-- fonction, declaration typee, definition

l1 :: [Int]
l1 = []

l2 :: [Int]
l2 = 1 : l1

l3 :: [Int]
l3 = 3:2:l2

l4 :: [Int]
l4 = [3,2,1]

l5 :: [Int]
l5 = [1..10]

l6 :: [Int]
l6 = [1,4..9]

l7 :: [Int]
l7 = [10,9..1]

-- myHead [1..10]
-- 1
myHead :: [Int] -> Int
myHead (x : xs) = x

-- myTail [1,2,3]
-- [2,3]
myTail :: [Int] -> [Int]
myTail (x : xs) = xs

-- application partielle


-- booleen


-- fonction recursive


-- liste d'entier, nil, cons, liste en comprehension


-- pattern matching

-- recursion :

-- tournois : n equipes et m matchs
-- ajouter une equipe qui rencontre toutes les autres : + n

-- matchs (n + 1) = m + n

-- delta
-- si pas d'equipe pas de match
-- si une seul equipe pas de match

--matchs :: Int -> Int
--matchs 0 = 0
--matchs n = matchs (n - 1) + (n - 1) 


-- myAppend [1..10] [11..20]
-- [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
myAppend :: [Int] -> [Int] -> [Int]
myAppend (x:xs) ys = x : myAppend xs ys
myAppend []     ys = ys

myAppend' :: [Int] -> [Int] -> [Int]
myAppend' xs ys | not (null xs) = head xs : myAppend' (tail xs) ys
                | otherwise     = ys

myAppend'' :: [Int] -> [Int] -> [Int]
myAppend'' xs ys | null xs       = ys
                 | not (null xs) = head xs : myAppend'' (tail xs) ys

myAppend4 :: [Int] -> [Int] -> [Int]
myAppend4 (x:xs) ys = 
    let suite = myAppend4 xs ys 
    in x:suite
myAppend4 []     ys = ys

myAppend5 :: [Int] -> [Int] -> [Int]
myAppend5 (x:xs) ys = x:suite where suite = myAppend5 xs ys
myAppend5 []     ys = ys

myAppend6 :: [Int] -> [Int] -> [Int]
myAppend6 xs ys = myAppend6' xs 
    where myAppend6' (x:xs) = x:myAppend6' xs
          myAppend6' []     = ys

-- a vous...
-- myInit [1..10]
-- [1,2,3,4,5,6,7,8,9]
myInit :: [Int] -> [Int]
myInit (x : y : xs) = x : myInit (y : xs)
myInit (x : []) = []
myInit [] = []

-- myLast [1..10]
-- 10
myLast :: [Int] -> Int
myLast (x : []) = x
myLast (x : xs) = myLast (xs)
myLast [] = undefined

myNull :: [Int] -> Bool
myNull [] = True
myNull (x : xs) = False

myNull' :: [Int] -> Bool
myNull' = undefined

-- myLength [1..10]
-- 10
myLength :: [Int] -> Int
myLength [] = 0
myLength (x : xs) = 1 + myLength xs 

-- myReverse [1..10]
-- [10,9,8,7,6,5,4,3,2,1]
myReverse :: [Int] -> [Int]
myReverse [] = []
myReverse (x : xs) = myAppend (myReverse xs) [x]

-- iteratif, comparer les complexites experimentalement
myReverse' :: [Int] -> [Int]
myReverse' xs = myReverse'' xs []
  where myReverse'' :: [Int] -> [Int] -> [Int]
        myReverse'' (x : xs) ys = myReverse'' xs ( x : ys)
        myReverse'' [] ys = ys

-- myConcat [[1..10],[2,3],[5,8,6]]
-- [1,2,3,4,5,6,7,8,9,10,2,3,5,8,6]
myConcat :: [[Int]] -> [Int]
myConcat [] = []
myConcat (x : xs)= myAppend x (myConcat xs)

myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x : xs) = x && myAnd xs

myOr ::  [Bool] -> Bool
myOr [] = False
myOr (x : xs) = x || myOr xs

-- myProduct [2,5,9]
-- 90
myProduct :: [Int] -> Int
myProduct [] = 1
myProduct (x : xs) = x * myProduct xs

-- pas d'element neutre pour max et min 
-- myTake 5 [1..10]
-- [1,2,3,4,5]
myTake :: Int -> [Int] -> [Int]
myTake 0 xs = []
myTake n [] = []
myTake x (y : ys) = y : (myTake (x-1) ys)

-- myDrop 5 [1..10]
-- [6,7,8,9,10]
myDrop :: Int -> [Int] -> [Int]
myDrop 0 xs = xs
myDrop n [] = []
myDrop x (y : ys) = (myDrop (x-1) ys)

-- cette fonction existe sous le nom !!
-- myBangBang [1,2,3,4,5,6,7] 4
-- 5
myBangBang :: [Int] -> Int -> Int
myBangBang (x : xs) 0 = x
myBangBang (x : xs) y = myBangBang xs (y-1)

-- myInsert 4 [1..10]
-- [1,2,3,4,4,5,6,7,8,9,10]
myInsert :: Int -> [Int] -> [Int]
myInsert x [] = [x]
myInsert x (h : t) | x > h    = h : myInsert x t
myInsert x (h : t)  = x : (h : t)

-- mySort [6,5,14,8,9,5,3,48,9,5,48,64,5,64]
-- [3,5,5,5,5,6,8,9,9,14,48,48,64,64]
mySort :: [Int] -> [Int]
mySort [] = []
mySort (x : xs) = myInsert x (mySort xs)