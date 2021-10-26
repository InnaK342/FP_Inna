{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
--Лабораторна робота №3
--студентки групи КН-31 підгрупа 1
--Ківачук Інна
--Варіант 7

--Мета:Набути досвiду визначення та використання функцiй вищого порядку.
--Завдання 1. Визначте вказанi функцiї в кожному з завдань: а) без застосування, б) з застосуванням вбудованих функцiй вищого порядку

--Визначити частоту кожного елемента списку, напр.: ("aaabbcaadddd") -> [('a',5), ('b',2), ('c',1), ('d',4)].
-- :load Лаб3//Lab_3.hs 
-- а) без застосування

foldr' :: (a -> b -> b) -> b -> [a] -> b 
foldr' f z [] =z
foldr' f z (a:as) = f a (foldr f z as)

add :: Eq a => a -> [(a, Int)] -> [(a, Int)]
add x [] = [(x, 1)]
add x ((y, n):rest) = if x == y
    then (y, n+1) : rest
    else (y, n) : add x rest
 
count :: Eq a => [a] -> [(a, Int)]
count = foldr' add []
-- count "asdssffff" -> [('f',4),('s',3),('d',1),('a',1)]
-- count "1111111234554" -> [('4',2),('5',2),('3',1),('2',1),('1',7)]

-- б) з застосуванням вбудованих функцiй вищого порядку

count_2 :: Eq a => [a] -> [(a, Int)]
count_2 = foldr add []
-- count_2 "asdssffff" -> [('f',4),('s',3),('d',1),('a',1)]
-- count_2 "1111111234554" -> [('4',2),('5',2),('3',1),('2',1),('1',7)]


--Завдання 2. Знайти простi дiльники числа.
-- а) без застосування
 
divis :: Integral a => a -> [a]
divis n = [x | x <- [2..n], [z | z <- [2 .. x-1], x `mod` z == 0] == [], mod n x == 0]
-- divis 15 -> [3,5]
-- divis 49 -> [7]

-- б) з застосуванням вбудованих функцiй вищого порядку
 
f :: Int -> Bool
f 1 = False
f 2 = True
f n 
    | length[x | x <- [2 .. n-1], mod n x == 0] > 0 = False
    | otherwise = True

divis_2 :: Int -> [Int]
divis_2 n = [x | x <- [1..n], f x, mod n x == 0]
-- divis_2 15 -> [3,5]
-- divis_2 49 -> [7]

--Висновок: В ході лабораторонї роботи ми набули досвiду визначення та використання функцiй вищого порядку.

