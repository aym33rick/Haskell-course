


-- questions ? 










{-# LANGUAGE Strict #-}
{-# LANGUAGE Strict #-}

import Data.List
import Data.Ord

-- ZF expressions / liste en comprehension

rectangle :: [(Int,Int)]
rectangle = [ (x,y) | x <- [1..4], y <- [1..5]]

triangle :: [(Int,Int)]
triangle = [ (x,y) | x <- [1..4], y <- [1..5], x<=y ]

triangle' :: [(Int,Int)]
triangle' = [ (x,y) | x <- [1..4], y <- [1..x] ]

dominos :: [(Int,Int)]
dominos = [ (i,j) | i <- [0..6], j <- [i..6] ]

-- myQSort [17,4,5,8,4,7,6,8]
-- [4,4,5,6,7,8,8,17]
myQSort :: Ord a => [a] -> [a]
myQSort (x:xs) = myQSort (filter (\n -> n<= x) xs) ++ [x] ++ myQSort (filter (\n -> n>x) xs)
myQSort [] = []
 
-- but du TP : trouver les solutions pour le compte est bon

-- sous listes et permutations pour considerer les nombres utilises dans le calcul

-- sous liste 

-- deja vu au bloc 2
-- sousListes [1..3]
-- [[],[3],[2],[2,3],[1],[1,3],[1,2],[1,2,3]]
sousListes :: [a] -> [[a]]
sousListes []     = [[]]
sousListes (x:xs) = ys ++ map (x:) ys
    where ys = sousListes xs

-- injections 0 [1..3]
-- [[0,1,2,3],[1,0,2,3],[1,2,0,3],[1,2,3,0]]
injections :: a -> [a] -> [[a]]
injections x (y:ys) = (x:y:ys) : map (y:) (injections x ys)
injections x [] = [[x]]

-- permuts [1..3]
-- [[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
permuts :: [a] -> [[a]]
permuts (x:xs) = [ sx | s <- permuts xs, sx <- injections x s ]
permuts []     = [[]]

-- permSousListes [1..3]
-- [[3],[2],[2,3],[3,2],[1],[1,3],[3,1],[1,2],[2,1],[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
permSousListes :: [a] -> [[a]]
permSousListes xs = [zs | ys <- sousListes xs, not (null ys), zs <- permuts ys]

-- partitionStricte [1..4]
-- [([1],[2,3,4]),([1,2],[3,4]),([1,2,3],[4])]
partitionStricte :: [a] -> [([a],[a])]
partitionStricte [x1,x2] = [([x1],[x2])] 
partitionStricte (x:xs) = ([x],xs): [ (x:ls,rs) | (ls,rs) <- partitionStricte xs]

-- I) generate and test (brute force)

data Op = Add | Sub | Mul | Div deriving Eq -- deriving (Show, Eq) 

instance Show Op where
   show Add = "+"
   show Sub = "-"
   show Mul = "*"
   show Div = "/"

validOp :: Op -> Int -> Int -> Bool
validOp Sub x y = x>y
validOp Div x y = x `mod` y == 0
validOp _   _ _ = True 

evalOp :: Op -> Int -> Int -> Int
evalOp Add x y = x + y
evalOp Sub x y = x - y
evalOp Mul x y = x * y
evalOp Div x y = x `div` y


data Exp = Val Int | App Op Exp Exp 
            deriving Show

-- step1: enumerate expressions
-- exps [3]
-- [Val 3]
-- exps [3,2]
-- [App + (Val 3) (Val 2),App - (Val 3) (Val 2),App * (Val 3) (Val 2),App / (Val 3) (Val 2)]
exps :: [Int] -> [Exp]
exps [x] = [Val x]
exps xs =
  [ App o g d 
  | (gs,ds) <- partitionStricte xs
  , g <- exps gs
  , d <- exps ds
  , o <- [Add,Sub,Mul,Div]
  ]

-- step2: filter out invalid expressions
-- evalExp (App Add (Val 2) (Val 4))
-- 6
-- evalExp (Val 4)
-- 4
evalExp :: Exp -> Int
evalExp (Val n) = n
evalExp (App o g d) = evalOp o (evalExp g) (evalExp d)

validExp :: Exp -> Bool
validExp (Val n) = n>0
validExp (App o g d) = validExp g && validExp d && validOp o (evalExp g) (evalExp d) 

solutions :: [Int] -> Int -> [Exp]
solutions nombres cible =
  let ns = permSousListes nombres
      es = concat (map exps ns)
      es' = filter validExp es
  in filter (\e -> evalExp e == cible) es'
   
test1 = solutions [1,3,7,10,25,50] 765


-- II) fusionner la generation et le filtrage des expressions invalides
  
exps2 :: [Int] -> [Exp]
exps2 [x] | validExp (Val x) = [Val x]
exps2 xs =
  [ App o g d 
  | (gs,ds) <- partitionStricte xs
  , g <- exps2 gs
  , d <- exps2 ds
  , o <- [Add,Sub,Mul,Div]
  , validOp o (evalExp g) (evalExp d)
  ]

solutions2 :: [Int] -> Int -> [Exp]
solutions2 nombres cible =
  let ns = permSousListes nombres
      es = concat (map exps2 ns)
  in filter (\e -> evalExp e == cible) es
  
test2 = solutions2 [1,3,7,10,25,50] 765

-- III) memoiser l'evaluation

data Exp' = Val' Int | App' Op Exp' Exp' Int 
            deriving Show

evalExp' :: Exp' -> Int
evalExp' (Val' n) = n
evalExp' (App' _ _ _ n) = n

exps3 :: [Int] -> [Exp']
exps3 [x] | validExp (Val x) = [Val' x]
exps3 xs =
  [App' o g d (evalOp o (evalExp' g) (evalExp' d))
  | (gs,ds) <- partitionStricte xs
  , g <- exps3 gs
  , d <- exps3 ds
  , o <- [Add,Sub,Mul,Div]
  ,validOp o (evalExp' g) (evalExp' d)
  ]

solutions3 :: [Int] -> Int -> [Exp']
solutions3 nombres cible =
  let ns = permSousListes nombres
      es = concat (map exps3 ns)
  in filter (\e -> evalExp' e == cible) es

test3 = solutions3 [1,3,7,10,25,50] 765


-- IV) exploiter des proprietes arithmetiques

-- pour reduire l'espace de recherche on ajoute les regles :
-- - pas de multiplication par 1 
-- - pas de division par 1
-- - addition et multiplication commutatives (ne considerer qu'un sens (quand les deux operandes sont differents))
validOp' :: Op -> Int -> Int -> Bool
validOp' Sub x y = x>y
validOp' Div x y = x `mod` y == 0 && y /= 1
validOp' Mul x y = x /= 1 && y /= 1 && x>=y
validOp' Add x y = x>=y
validOp' _   _ _ = True 

exps4 :: [Int] -> [Exp']
exps4 [x] = [Val' x]
exps4 xs =
  [App' o g d (evalOp o (evalExp' g) (evalExp' d))
  | (gs,ds) <- partitionStricte xs
  , g <- exps4 gs
  , d <- exps4 ds
  , o <- [Add,Sub,Mul,Div]
  ,validOp' o (evalExp' g) (evalExp' d)
  ]

solutions4 :: [Int] -> Int -> [Exp']
solutions4 nombres cible =
  let ns = permSousListes nombres
      es = concat (map exps4 ns)
  in filter (\e -> evalExp' e == cible) es

test4 = solutions4 [1,3,7,10,25,50] 765

-- nombre de solutions

nombreDeSolutions3 = length test3
nombreDeSolutions4 = length test4

-- V) ne retourner qu'une solution exacte ou bien la plus proche 

solutions5 :: [Int] -> Int -> Exp'
solutions5 nombres cible =
  let ns = permSousListes nombres
      es = concat (map exps4 ns)
  in  minimumBy (comparing (\e -> abs (evalExp' e - cible) ) ) es

test5 = solutions5 [1,3,7,10,25,50] 765
test6 = solutions5 [1,3,7,10,25,50] 831

-- VI) affichez les expressions sous forme infixe en evitant des parentheses inutiles
--instance Show Exp' where 
--    show :: Exp' -> String
--    show e = undefined

-- VII) generalisez certaines fonctions avec de l'ordre superieur afin de reduire la duplication de code dans ce programme

-- misc : cherchez les solutions avec le moins d'operations en priorite