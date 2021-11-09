{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
--Лабораторна робота №4
--студентки групи КН-31 підгрупа 1
--Ківачук Інна
--Варіант 7

--Мета: Ознайомитись з системою типiв та класiв типiв. Набути досвiду визначення нових типiв та класiв типiв i їх використання.

--Публiкацiї. Зберiгаються данi про публiкацiї, якi можуть бути книгою (автор/спiвавтори, назва, мiсто, видавництво, рiк), 
--статтею (автор/спiвавтори, назва статтi, назва журналу, рiк, номер журналу, сторiнки) або 
--тезами доповiдi (автор/спiвавтори, назва доповiдi, назва конференцiї, мiсто, рiк, сторiнки). Визначне функцiї для :

--пошуку усiх статей (книг, тез) вказаного автора;

data Book = Book {
authorBook :: String,
nameBook :: String,
cityBook :: String,
publishingHouse :: String,
yearBook :: Int
} deriving (Eq, Show)

data Article = Article {
authorArticle :: String,
nameArticle :: String,
nameMagazine :: String,
yearArticle :: Int,
magazineNumber :: Int,
pageNumber :: Int
} deriving (Eq, Show)

data Thesis = Thesis {
authorThesis :: String,
nameThesis :: String,
nameConference :: String,
cityThesis :: String,
yearThesis :: Int,
pageThesis:: Int
} deriving (Eq, Show)


fBook :: [Book]
fBook = [(Book "John" "Adventures of insects" "London" "Ebury" 1995),(Book "Stella" "Murder in New York" "Kyiv" "CornerStone" 2010),(Book "Lola" "Come to me" "Lviv" "LvivBooks" 2021) ]

fArticle :: [Article]
fArticle = [(Article "John" "Secrets of the trip" "Trip to america" 2015 12 334),(Article "Lola" "Animals in zoo" "Zoo" 1999 17 25)]

fThesis :: [Thesis]
fThesis = [(Thesis "John" "The live of the rich people" "Live conference №2" "Moscow" 2020 159)]

applyEach :: [(a -> b)] -> [a] -> [b]
applyEach _ [] = []
applyEach (x:xs) (y:ys) = x y : applyEach xs ys

elem' :: String -> [Book] -> String
elem' _ [] = "False"
elem' x (y : ys) = if x == authorBook y then nameBook y else elem' x ys

elem2' :: String -> [Article] -> String
elem2' _ [] = "False"
elem2' x (y : ys) = if x == authorArticle y then nameArticle y else elem2' x ys

elem3' :: String -> [Thesis] -> String
elem3' _ [] = "False"
elem3' x (y : ys) = if x == authorThesis y then nameThesis y else elem3' x ys

check :: String -> [String]
check a = [elem' a fBook, elem2' a fArticle,elem3' a fThesis]
    
-- :load Lab4//Lab_4.hs

-- > check "John"       
-- ["Adventures of insects","Secrets of the trip","The live of the rich people"]

-- > check "Stella"     
-- ["Murder in New York","False","False"]

-- > check "Lola"  
-- ["Come to me","Animals in zoo","False"]

-- > check "Nina"
-- ["False","False","False"]

--Висновок: В ході лабораторної роботи ми ознайомились з системою типiв та класiв типiв та набули досвiду визначення нових типiв та класiв типiв i їх використання.


