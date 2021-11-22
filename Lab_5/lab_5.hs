{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import System.IO 
--Лабораторна робота №5
--студентки групи КН-31 підгрупа 1
--Ківачук Інна
--Варіант 7

--Мета: Ознайомитись з модульною органiзацiєю програм та засобами введення- виведення. Набути досвiду компiляцiї Haskell-програм.

-- cd Lab_5
-- :load lab_5.hs 

-- Визначити частоту кожного елемента списку, напр.: ("aaabbcaadddd") -> [('a',5), ('b',2), ('c',1), ('d',4)].

add :: Eq a => a -> [(a, Int)] -> [(a, Int)]
add x [] = [(x, 1)]
add x ((y, n):rest) = if x == y
    then (y, n+1) : rest
    else (y, n) : add x rest

count_2 :: Eq a => [a] -> [(a, Int)]
count_2 = foldr add []

-- Знайти простi дiльники числа.
 
divis :: Integral a => a -> [a]
divis n = [x | x <- [2..n], [z | z <- [2 .. x-1], x `mod` z == 0] == [], mod n x == 0]

countConsoleToConsole :: IO ()
countConsoleToConsole = do
    putStrLn "Введіть список"
    a <- getLine
    let r = count_2 a
    putStrLn "Результат"
    print r

-- > countConsoleToConsole
-- Введіть список
-- asdssffff
-- Результат
-- [('f',4),('s',3),('d',1),('a',1)]
    
countConsoleToFile :: IO ()
countConsoleToFile = do
    putStrLn "Введіть список"
    a <- getLine
    let r = count_2 a
    writeFile "countOutput.txt" ("Результат: " ++ show r)

-- > countConsoleToFile
-- Введіть список
-- asdssffff

countFileToConsole :: IO ()
countFileToConsole = do
    a <- readFile "countInput.txt"
    let r = count_2 a
    putStrLn "Результат"
    print r

-- > countFileToConsole
-- Результат
-- [('f',4),('s',3),('d',1),('a',1)]

countFileToFile :: IO ()
countFileToFile = do
    a <- readFile "countInput.txt"
    let r = count_2 a
    writeFile "countOutput.txt" ("Результат: " ++ show r)

-- > countFileToFile

divisConsoleToConsole :: IO ()
divisConsoleToConsole = do
    putStrLn "Введіть число"
    a <- getLine
    let number = read a :: Integer
    let r = divis number
    putStrLn "Результат"
    print r

-- > divisConsoleToConsole
-- Введіть число
-- 15
-- Результат
-- [3,5]

divisConsoleToFile :: IO ()
divisConsoleToFile = do
    putStrLn "Введіть число"
    a <- getLine
    let number = read a :: Integer
    let r = divis number
    writeFile "divisOutput.txt" ("Результат: " ++ show r)

-- > divisConsoleToFile
-- Введіть число
-- 15

divisFileToConsole :: IO ()
divisFileToConsole = do
    s <- openFile "divisInput.txt" ReadMode
    a <- hGetLine s
    let number = read a :: Integer
    let r = divis number
    putStrLn "Результат"
    print r

-- > divisFileToConsole
-- Результат
-- [3,5]

divisFileToFile :: IO ()
divisFileToFile = do
    s <- openFile "divisInput.txt" ReadMode
    a <- hGetLine s
    let number = read a :: Integer
    let r = divis number
    writeFile "divisOutput.txt" ("Результат: " ++ show r)

-- > divisFileToFile

--Висновок: В ході лабораторонї роботи ми ознайомились з модульною органiзацiєю програм та засобами введення- виведення. Набули досвiду компiляцiї Haskell-програм.