-- questions ?

-- une correction (attention min(fond,forme)), rappel : beau !

-- on generalise (autant que possible) le type des fonctions du bloc1
-- myHead [1..10]
-- 1
myHead :: [a] -> a
myHead (x:_) = x

-- myTail [1..10]
-- [2,3,4,5,6,7,8,9,10]
myTail :: [a] -> [a]
myTail (_:xs) = xs

-- myAppend [1..4] [7..8]
-- [1,2,3,4,7,8]
myAppend :: [a] -> [a] -> [a]
myAppend xs ys = myAppend' xs
  where myAppend' (x:xs) = x:myAppend' xs
        myAppend' [] = ys

-- myInit [1..10]
-- [1,2,3,4,5,6,7,8,9]
myInit :: [a] -> [a]
myInit [_]    = []
myInit (x:xs) = x:myInit xs

-- myLast [1..10]
-- 10
myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs

myNull :: [a] -> Bool
myNull [] = True
myNull _  = False

l1 :: [a]
l1 = []

l2 :: [Int]
l2 = 1:l1

l3 :: [Bool]
l3 = True:l1

-- myLength [1..10]
-- 10
myLength :: [a] -> Int
myLength (_:xs) = 1 + myLength xs
myLength []     = 0

myNull' :: [a] -> Bool
myNull' xs = length xs==0

-- myReverse [1..10]
-- [10,9,8,7,6,5,4,3,2,1]
myReverse :: [a] -> [a]
myReverse (x:xs) = myReverse xs ++ [x]
myReverse []     = []

-- myConcat [[1..10],[2,3],[5,8,6]]
-- [1,2,3,4,5,6,7,8,9,10,2,3,5,8,6]
myConcat :: [[a]] -> [a]
myConcat (bs:bss) = bs ++ myConcat bss
myConcat [] = []

-- myTake 2 [5,6,4,7,8,9]
-- [5,6]
myTake :: Int -> [a] -> [a]
myTake 0 _  = []
myTake n [] = []
myTake n (x:xs) = x:myTake (n-1) xs

-- myDrop 2 [5,6,4,7,8,9]
-- [4,7,8,9]
myDrop :: Int -> [a] -> [a]
myDrop 0 xs = xs
myDrop n [] = []
myDrop n (x:xs) = myDrop (n-1) xs

-- myBangBang [1,2,3,4,5,6,7] 4
-- 5
myBangBang :: [a] -> Int -> a -- (!!)
myBangBang (x:xs) 0 = x
myBangBang (x:xs) n = myBangBang xs (n-1)

-- myInsert 4 [1..10]
-- [1,2,3,4,4,5,6,7,8,9,10]
myInsert :: Ord a => a -> [a] -> [a]
myInsert x [] = [x]
myInsert x (y:ys) | x>y       = y:myInsert x ys
                  | otherwise = x:y:ys

{-
class Eq a where
  (==) :: a -> a -> Bool
  x == y = not (x/=y)
  (/=) :: a -> a -> Bool
  x /= y = not (x==y)

instance Eq Bool where
  True  == True  = True
  False == False = True
  _     == _     = False

instance Eq Int where
  x == y = Processeur.cmp x y

instance Eq a => Eq [a] where
  []     == []     = True
  (x:xs) == (y:ys) = x==y && xs==ys
  _      == _      = False

class Eq a => Ord a where
  (>) :: a -> a -> Bool
  (>=) :: a -> a -> Bool
  x >= y = x==y || x>y
-}

-- classes : Eq, Ord, Show
-- mySort [6,5,14,8,9,5,3,48,9,5,48,64,5,64]
-- [3,5,5,5,5,6,8,9,9,14,48,48,64,64]
mySort :: Ord a => [a] -> [a]
mySort (x:xs) = myInsert x (mySort xs)
mySort []     = []

myNull'' :: Eq a => [a] -> Bool
myNull'' xs = xs==[]


-- NEW STUFF

-- ordre superieur
-- myTakeWhile (<5) [1..10]
-- [1,2,3,4]
myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile f (x:xs)
  | f x          = x:myTakeWhile f xs
  | otherwise    = []
myTakeWhile f [] = []

-- section : (2>) plus partiellement appliquee a son premier argument
-- section : (>2) plus partiellement appliquee a son second  argument

-- myHead :: [Int] -> Int moins general myHead :: [a] -> a

-- donner le type le plus general de la fonction myCompose (aka (.))
-- myCompose (*2) (+5) 3
-- 16
myCompose :: (b -> c) -> (a -> b) -> a -> c
myCompose f g x = f (g x)

-- donner une definition de la fonction myMap
-- myMap (*2) [1..10]
-- [2,4,6,8,10,12,14,16,18,20]
myMap :: (a -> b) -> [a] -> [b]
myMap f (x:xs) = f x:myMap f xs
myMap f []     = []

test1 = myMap odd [1..10]

-- calcul des sous liste en utilisant map
-- sousListes [2,3,4]
-- [[],[4],[3],[3,4],[2],[2,4],[2,3],[2,3,4]]
sousListes :: [a] -> [[a]]
sousListes (x:xs) = sousListes xs ++ map (x:) (sousListes xs)
sousListes []     = [[]]

-- une fonction plus generale: foldr
-- inferer le type (le plus general) de foldr
-- forme graphique de la liste en peigne

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f k (x:xs) = f x (myFoldr f k xs)
myFoldr f k []     = k

myAnd' :: [Bool] -> Bool
myAnd' = undefined

-- une parenthese sur les lambda anonymes

add' :: Int -> Int -> Int
add' x y = x + y

add'' :: Int -> Int -> Int
add'' = \x -> \y -> x + y

-- un "nouveau type" String

s1 :: String -- [Char]
s1 = "des caracteres"

-- un nouveau type tuples

myFst :: (a,b) -> a
myFst (x,y) = x

-- et des triplets, etc...
-- fixPoint (*1) 3
-- 3
fixPoint :: Eq a => (a -> a) -> a -> a
fixPoint f x | f x == x = x
             | otherwise = fixPoint f (f x)

-- TODO: definir recursivement
-- myDropWhile (<3) [1..10]
-- [3,4,5,6,7,8,9,10]
myDropWhile :: (a -> Bool) -> [a] -> [a]
myDropWhile f (x:xs) | f x = myDropWhile f xs
                     | otherwise    = x : (myDropWhile f xs)
myDropWhile _ [] = []

-- myElem 3 [5..10]
-- False
myElem :: Eq a => a -> [a] -> Bool
myElem x (y : ys) = x == y || myElem x ys
myElem _ [] = False

-- myNotElem 3 [1..10]
-- False
myNotElem :: Eq a => a -> [a] -> Bool
myNotElem x (y : ys) | x == y = False && myNotElem x ys
                     | otherwise = True && myNotElem x ys
myNotElem _ [] = True

-- myFilter (>4) [2,1,56,5,7,8,98,4,5]
-- [56,5,7,8,98,5]
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f (x:xs) | f x = x : myFilter f xs
                  | otherwise    = myFilter f xs
myFilter _ [] = []

-- mySplitAt 4 [1,5,8,9,6,3,2,5,4]
-- ([1,5,8,9],[6,3,2,5,4])
mySplitAt :: Int -> [a] -> ([a],[a])
mySplitAt _ [] = ([],[])
mySplitAt 0 rs = ([],rs)
mySplitAt n (x:xs) = (x:ls,rs) where (ls, rs) = mySplitAt (n-1) xs

-- myZip [1..10] [11..20]
-- [(1,11),(2,12),(3,13),(4,14),(5,15),(6,16),(7,17),(8,18),(9,19),(10,20)]
myZip :: [a] -> [b] -> [(a,b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys)= (x,y) : myZip xs ys

-- myZipWith (*) [1..10] [11..20]
-- [11,24,39,56,75,96,119,144,171,200]
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

-- myCurry fst 2 3
-- 2
myCurry :: ((a,b) -> c) -> a -> b -> c
myCurry f x y = f(x, y)

-- myUncurry mod (8,4)
-- 0
myUncurry :: (a -> b -> c) -> (a,b) -> c
myUncurry f (x , y) = f x y

-- myUnzip [(1,2),(3,4),(5,6)]
-- ([1,3,5],[2,4,6])
myUnzip :: [(a,b)] -> ([a],[b])
myUnzip [] = ([],[])
myUnzip ((x,y):l) = (x:ls,y:rs) where (ls,rs)= myUnzip l

-- define myZipWith' NON recursively
myZipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith' = undefined

-- TODO: redefinir en utilisant foldr
-- myConcat [[1..10],[2,3],[5,8,6]]
-- [1,2,3,4,5,6,7,8,9,10,2,3,5,8,6]
myConcat' :: [[a]] -> [a]
myConcat' l = foldr (++) [] l

myMap' ::  (a -> b) -> [a] -> [b]
myMap' f = foldr (\x y -> f x : y) []

myOr' ::  [Bool] -> Bool
myOr' = foldr (||) False

-- myAny (>2) [1,1,1,1]
-- False
myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr (\x y -> f x || y) False

-- myAll (>2) [2,2,2,2,2]
-- False
-- myAll (>1) [2,2,2,2,2]
-- True
myAll :: (a -> Bool) -> [a] -> Bool
myAll f = foldr (\x y -> f x && y) True

-- myProduct [1,2,3,4,5]
-- 120
myProduct :: [Int] -> Int
myProduct = foldr (*) 1

-- mySum [1,2,3,4,5]
-- 15
mySum :: [Int] -> Int
mySum = foldr (+) 0

mySort' :: [Int] -> [Int]
mySort' = foldr (\x y -> myInsert x y) []

myReverse' :: [a] -> [a]
myReverse' = foldr (\x y -> y ++ [x]) []

-- define recursively

myElem' :: Eq a => a -> [a] -> Bool
myElem' = undefined

myNotElem' :: Eq a => a -> [a] -> Bool
myNotElem' = undefined

-- TODO: calculuer les 50 plus petits nombres premiers 2, 3, 5, 7, 11...

premiers :: [Int]
premiers = crible [2..]

crible :: [Int] -> [Int]
crible (x:xs) = undefined

test2 = take 50 premiers