# Haskell

Ce cours intervient dans le module Langages de programmation et concerne le langage Haskell. 
Il est délivré par M.Douence.

## 1) Créer un projet avec stack
```
stack new my-project
```
## 2) Compiler un projet avec stack
```
cd my-project
stack build
stack exec my-project-exe
```
## 3) Utiliser le terminal ghci
```
stack ghci
```
Reload
```
:r
```
Arreter le processus en cours
```
Ctrl+C
```
Sortir du terminal
```
Ctrl+Z
```

## 4) Fonction à connaitre

- ### Sub
    Fonction qui soustrait le deuxième paramètre au premier
    ``` haskell
    mySub :: Int -> Int -> Int
    mySub x y = x - y
    ```
    Trace d'exécution :
    ``` shell
    ghci> mySub 5 3
    ghci> 2
    ```
- ### Neg
  Fonction qui retourne le négatif d'un nombre
  ``` haskell
  myNeg :: Int -> Int
  myNeg = mySub 0
  ```
  Trace d'exécution :
  ``` shell
  ghci> myNeg 3
  ghci> -3
  ```
- ### Head
  Fonction qui retourne la tête d'une liste
  ``` haskell
  myHead :: [Int] -> Int
  myHead (x : xs) = x
  ```
  Trace d'exécution :
  ``` shell
  ghci> myHead [1..10]
  ghci> 1
  ```
- ### Tail
  Fonction qui retourne la queue d'une liste
  ``` haskell
  myTail :: [Int] -> [Int]
  myTail (x : xs) = xs
  ```
  Trace d'exécution :
  ``` shell
  ghci> myTail [1,2,3]
  ghci> [2,3]
  ```
- ### Append
  Fonction qui ajoute une liste à la suite d'une autre
  ``` haskell
  myAppend :: [Int] -> [Int] -> [Int]
  myAppend (x:xs) ys = x : myAppend xs ys
  myAppend []     ys = ys
  ```
  Trace d'exécution :
  ``` shell
  ghci> myAppend [1..10] [11..20]
  ghci> [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
  ```
- ### Init
  Fonction qui retourne une liste sans son dernier élément
  ``` haskell
  myInit :: [Int] -> [Int]
  myInit (x : y : xs) = x : myInit (y : xs)
  myInit (x : []) = []
  myInit [] = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myInit [1..10]
  ghci> [1,2,3,4,5,6,7,8,9]
  ```
- ### Last
  Fonction qui retourne le dernier élément d'une liste
  ``` haskell
  myLast :: [Int] -> Int
  myLast (x : []) = x
  myLast (x : xs) = myLast (xs)
  myLast [] = undefined
  ```
  Trace d'exécution :
  ``` shell
  ghci> myLast [1..10]
  ghci> 10
- ### Null
  Fonction qui retourne True si l'élément est null False sinon
  ``` haskell
  myNull :: [Int] -> Bool
  myNull [] = True
  myNull (x : xs) = False
  ```
- ### Length
  Fonction qui retourne la longueur d'une liste
  ``` haskell
  myLength :: [Int] -> Int
  myLength [] = 0
  myLength (x : xs) = 1 + myLength xs
  ```
  Trace d'exécution :
  ``` shell
  ghci> myLength [1..10]
  ghci> 10
  ```
- ### Reverse
  Fonction qui retourne l'inverse d'une liste
  ``` haskell
  myReverse :: [Int] -> [Int]
  myReverse [] = []
  myReverse (x : xs) = myAppend (myReverse xs) [x]
  ```
  Trace d'exécution :
  ``` shell
  ghci> myReverse [1..10]
  ghci> [10,9,8,7,6,5,4,3,2,1]
  ```
- ### Concat
  Fonction qui retourne les éléments d'une liste concaténée 
  ``` haskell
  myConcat :: [[Int]] -> [Int]
  myConcat [] = []
  myConcat (x : xs)= myAppend x (myConcat xs)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myConcat [[1..10],[2,3],[5,8,6]]
  ghci> [1,2,3,4,5,6,7,8,9,10,2,3,5,8,6]
  ```
- ### And
  Fonction qui retourne effectue un && sur tous les éléments d'une liste de booléen
  ``` haskell
  myAnd :: [Bool] -> Bool
  myAnd [] = True
  myAnd (x : xs) = x && myAnd xs
  ```
- ### Or
  Fonction qui retourne effectue un || sur tous les éléments d'une liste de booléen
  ``` haskell
  myOr ::  [Bool] -> Bool
  myOr [] = False
  myOr (x : xs) = x || myOr xs
  ```
- ### Product
  Fonction qui multiplie tous les éléments d'une liste
  ``` haskell
  myProduct :: [Int] -> Int
  myProduct [] = 1
  myProduct (x : xs) = x * myProduct xs
  ```
  Trace d'exécution :
  ``` shell
  ghci> myProduct [2,5,9]
  ghci> 
- ### Take
  Fonction qui retourne les x premiers éléments d'une liste
  ``` haskell
  myTake :: Int -> [Int] -> [Int]
  myTake 0 xs = []
  myTake n [] = []
  myTake x (y : ys) = y : (myTake (x-1) ys)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myTake 5 [1..10]
  ghci> [1,2,3,4,5]
  ```
- ### Drop
  Fonction qui retourne les x dernier éléments d'une liste
  ``` haskell
  myDrop :: Int -> [Int] -> [Int]
  myDrop 0 xs = xs
  myDrop n [] = []
  myDrop x (y : ys) = (myDrop (x-1) ys)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myDrop 5 [1..10]
  ghci> [6,7,8,9,10]
  ```
- ### BangBang (!!)
  Fonction qui retourne les x-ème élément d'une liste
  ``` haskell
  myBangBang :: [Int] -> Int -> Int
  myBangBang (x : xs) 0 = x
  myBangBang (x : xs) y = myBangBang xs (y-1)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myBangBang [1,2,3,4,5,6,7] 4
  ghci> 5
  ```
- ### Insert
  Fonction qui insert un élément juste avant le premier plus grand qu'il rencontre
  ``` haskell
  myInsert :: Int -> [Int] -> [Int]
  myInsert x [] = [x]
  myInsert x (h : t) | x > h    = h : myInsert x t
  myInsert x (h : t)  = x : (h : t)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myInsert 4 [1..10]
  ghci> [1,2,3,4,4,5,6,7,8,9,10]
  ```
- ### Sort
  Fonction qui trie une liste
  ``` haskell
  mySort :: [Int] -> [Int]
  mySort [] = []
  mySort (x : xs) = myInsert x (mySort xs)
  ```
  Trace d'exécution :
  ``` shell
  ghci> mySort [6,5,14,8,9,5,3,48,9,5,48,64,5,64]
  ghci> [3,5,5,5,5,6,8,9,9,14,48,48,64,64]
  ```
- ### TakeWhile
  Fonction qui prend les éléments d'une liste tant que les éléments respecte une certaine condition
  ``` haskell
  myTakeWhile :: (a -> Bool) -> [a] -> [a]
  myTakeWhile f (x:xs)
  | f x          = x:myTakeWhile f xs
  | otherwise    = []
  myTakeWhile f [] = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myTakeWhile (<5) [1..10]
  ghci> [1,2,3,4]
  ```
- ### Compose
  Fonction qui compose deux fonctions et l'applique à un paramètre (f∘g(x) = f(g(x)))
  ``` haskell
  myCompose :: (b -> c) -> (a -> b) -> a -> c
  myCompose f g x = f (g x)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myCompose (*2) (+5) 3
  ghci> 16
  ```
- ### Map
  Fonction qui applique une fonction à une liste
  ``` haskell
  myMap :: (a -> b) -> [a] -> [b]
  myMap f (x:xs) = f x:myMap f xs
  myMap f []     = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myMap (*2) [1..10]
  ghci> [2,4,6,8,10,12,14,16,18,20]
  ```
- ### SousListes
  Fonction qui renvoie toutes les sous listes d'une liste
  ``` haskell
  sousListes :: [a] -> [[a]]
  sousListes (x:xs) = sousListes xs ++ map (x:) (sousListes xs)
  sousListes []     = [[]]
  ```
  Trace d'exécution :
  ``` shell
  ghci> sousListes [2,3,4]
  ghci> [[],[4],[3],[3,4],[2],[2,4],[2,3],[2,3,4]]
  ```
- ### Foldr
  TODO
  ``` haskell
  myFoldr :: (a -> b -> b) -> b -> [a] -> b
  myFoldr f k (x:xs) = f x (myFoldr f k xs)
  myFoldr f k []     = k
  ```
  Trace d'exécution :
  ``` shell
  ghci> TODO
  ghci> TODO
  ```
- ### Fst
  Fonction qui renvoie le premier élément d'un tuple
  ``` haskell
  myFst :: (a,b) -> a
  myFst (x,y) = x
  ```
  Trace d'exécution :
  ``` shell
  ghci> myFst (2,3)
  ghci> 2
  ```
- ### FixPoint
  Fonction qui renvoie le point fix d'une fonction
  ``` haskell
  fixPoint :: Eq a => (a -> a) -> a -> a
  fixPoint f x | f x == x = x
               | otherwise = fixPoint f (f x)
  ```
  Trace d'exécution :
  ``` shell
  ghci> fixPoint (*1) 3
  ghci> 3
  ```
- ### DropWhile
  Fonction qui next les éléments d'une liste tant qu'il respecte une certaine condition
  ``` haskell
  myDropWhile :: (a -> Bool) -> [a] -> [a]
  myDropWhile f (x:xs) | f x = myDropWhile f xs
                       | otherwise    = x : (myDropWhile f xs)
  myDropWhile _ [] = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myDropWhile (<3) [1..10]
  ghci> [3,4,5,6,7,8,9,10]
  ```
- ### Elem
  Fonction qui renvoie True si un élément x est présent dans une liste sinon False
  ``` haskell
  myElem :: Eq a => a -> [a] -> Bool
  myElem x (y : ys) = x == y || myElem x ys
  myElem _ [] = False
  ```
  Trace d'exécution :
  ``` shell
  ghci> myElem 3 [5..10]
  ghci> False
  ```
- ### NotElem
  Fonction qui renvoie True si un élément x n'est pas présent dans une liste sinon False
  ``` haskell
  myNotElem :: Eq a => a -> [a] -> Bool
  myNotElem x (y : ys) | x == y = False && myNotElem x ys
                       | otherwise = True && myNotElem x ys
  myNotElem _ [] = True
  ```
  Trace d'exécution :
  ``` shell
  ghci> myNotElem 3 [1..10]
  ghci> False
  ```
- ### Filter
  Fonction qui filtre une liste en fonction d'une condition
  ``` haskell
  myFilter :: (a -> Bool) -> [a] -> [a]
  myFilter f (x:xs) | f x = x : myFilter f xs
                    | otherwise    = myFilter f xs
  myFilter _ [] = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myFilter (>4) [2,1,56,5,7,8,98,4,5]
  ghci> [56,5,7,8,98,5]
  ```
- ### SplitAt
  Fonction qui coupe une liste en deux à un n-ième élément
  ``` haskell
  mySplitAt :: Int -> [a] -> ([a],[a])
  mySplitAt _ [] = ([],[])
  mySplitAt 0 rs = ([],rs)
  mySplitAt n (x:xs) = (x:ls,rs) where (ls, rs) = mySplitAt (n-1) xs
  ```
  Trace d'exécution :
  ``` shell
  ghci> mySplitAt 4 [1,5,8,9,6,3,2,5,4]
  ghci> ([1,5,8,9],[6,3,2,5,4])
  ```
- ### Zip
  Fonction qui crée des tuples à partir de deux listes
  ``` haskell
  myZip :: [a] -> [b] -> [(a,b)]
  myZip [] _ = []
  myZip _ [] = []
  myZip (x:xs) (y:ys)= (x,y) : myZip xs ys
  ```
  Trace d'exécution :
  ``` shell
  ghci> myZip [1..10] [11..20]
  ghci> [(1,11),(2,12),(3,13),(4,14),(5,15),(6,16),(7,17),(8,18),(9,19),(10,20)]
  ```
- ### ZipWith
  Fonction qui merge deux listes grâce à une fonction
  ``` haskell
  myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
  myZipWith f [] _ = []
  myZipWith f _ [] = []
  myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys
  ```
  Trace d'exécution :
  ``` shell
  ghci> myZipWith (*) [1..10] [11..20]
  ghci> [11,24,39,56,75,96,119,144,171,200]
  ```
- ### Curry
  TODO
  ``` haskell
  myCurry :: ((a,b) -> c) -> a -> b -> c
  myCurry f x y = f(x, y)
  ```
  Trace d'exécution :
  ``` shell
  ghci> myCurry fst 2 3
  ghci> 2
  ```
- ### Uncurry
  TODO
  ``` haskell
  myUncurry :: (a -> b -> c) -> (a,b) -> c
  myUncurry f (x , y) = f x y
  ```
  Trace d'exécution :
  ``` shell
  ghci> myUncurry mod (8,4)
  ghci> 0
  ```
- ### Unzip
  Fonction qui dézip un tableau de tuple
  ``` haskell
  myUnzip :: [(a,b)] -> ([a],[b])
  myUnzip [] = ([],[])
  myUnzip ((x,y):l) = (x:ls,y:rs) where (ls,rs)= myUnzip l
  ```
  Trace d'exécution :
  ``` shell
  ghci> myUnzip [(1,2),(3,4),(5,6)]
  ghci> ([1,3,5],[2,4,6])
  ```
- ### Any
  Fonction qui renvoie True si un élément d'une liste remplie la condition sinon False
  ``` haskell
  myAny :: (a -> Bool) -> [a] -> Bool
  myAny f = foldr (\x y -> f x || y) False
  ```
  Trace d'exécution :
  ``` shell
  ghci> myAny (>2) [1,1,1,1]
  ghci> False
  ```
- ### All
  Fonction qui renvoie True si tout les éléments d'une liste remplie la condition sinon False
  ``` haskell
  myAll :: (a -> Bool) -> [a] -> Bool
  myAll f = foldr (\x y -> f x && y) True
  ```
  Trace d'exécution :
  ``` shell
  ghci> myAll (>2) [2,2,2,2,2]
  ghci> False
  ghci> myAll (>1) [2,2,2,2,2]
  ghci> True
  ```
- ### Product
  Fonction qui le produit de deux entier
  ``` haskell
  myProduct :: [Int] -> Int
  myProduct = foldr (*) 1
  ```
  Trace d'exécution :
  ``` shell
  ghci> myProduct [1,2,3,4,5]
  ghci> 120
  ```
- ### Sum
  Fonction qui le produit de deux entiers
  ``` haskell
  mySum :: [Int] -> Int
  mySum = foldr (+) 0
  ```
  Trace d'exécution :
  ``` shell
  ghci> mySum [1,2,3,4,5]
  ghci> 15
  ```
- ### Premiers
  TODO
  ``` haskell
  premiers :: [Int]
  premiers = crible [2..]
  ```
  Trace d'exécution :
  ``` shell
  TODO
  ```
- ### Crible
  TODO
  ``` haskell
  crible :: [Int] -> [Int]
  crible (x:xs) = TODO
  ```
  Trace d'exécution :
  ``` shell
  TODO
  ```
- ### QSort
  Fonction qui renvoie une liste triée
  ``` haskell
  myQSort :: Ord a => [a] -> [a]
  myQSort (x:xs) = myQSort (filter (\n -> n<= x) xs) ++ [x] ++ myQSort (filter (\n -> n>x) xs)
  myQSort [] = []
  ```
  Trace d'exécution :
  ``` shell
  ghci> myQSort [17,4,5,8,4,7,6,8]
  ghci> [4,4,5,6,7,8,8,17]
  ```
  
# Création des chiffres, des chiffres et des lettres

## Préparation des fonctions utiles

- ### Injections
  Fonction qui inject un élément dans une liste à chaque position 
  ``` haskell
  injections :: a -> [a] -> [[a]]
  injections x (y:ys) = (x:y:ys) : map (y:) (injections x ys)
  injections x [] = [[x]]
  ```
  Trace d'exécution :
  ``` shell
  ghci> injections 0 [1..3]
  ghci> [[0,1,2,3],[1,0,2,3],[1,2,0,3],[1,2,3,0]]
  ```
- ### Permuts
  Fonction qui renvoie toutes les possibilitées de mélange d'une liste
  ``` haskell
  permuts :: [a] -> [[a]]
  permuts (x:xs) = [ sx | s <- permuts xs, sx <- injections x s ]
  permuts []     = [[]]
  ```
  Trace d'exécution :
  ``` shell
  ghci> permuts [1..3]
  ghci> [[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
  ```
- ### PermSousListes
  Fonction qui renvoie toutes les sous listes d'une leste et leurs possibilitées de mélange
  ``` haskell
  permSousListes :: [a] -> [[a]]
  permSousListes xs = [zs | ys <- sousListes xs, not (null ys), zs <- permuts ys]
  ```
  Trace d'exécution :
  ``` shell
  ghci> permSousListes [1..3]
  ghci> [[3],[2],[2,3],[3,2],[1],[1,3],[3,1],[1,2],[2,1],[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
  ```
- ### PartitionStricte
  Fonction qui renvoie toutes les partitions possible d'une liste
  ``` haskell
  partitionStricte :: [a] -> [([a],[a])]
  partitionStricte [x1,x2] = [([x1],[x2])]
  partitionStricte (x:xs) = ([x],xs): [ (x:ls,rs) | (ls,rs) <- partitionStricte xs]
  ```
  Trace d'exécution :
  ``` shell
  ghci> partitionStricte [1..4]
  ghci> [([1],[2,3,4]),([1,2],[3,4]),([1,2,3],[4])]
  ```

## Implementation du jeu

TODO























