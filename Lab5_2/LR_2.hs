{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Yesod
import Control.Applicative
import Data.Text (Text, unpack)

data MFormExample = MFormExample

mkYesod "MFormExample" [parseRoutes|
/ RootR GET
|]

instance Yesod MFormExample

instance RenderMessage MFormExample FormMessage where
  renderMessage _ _ = defaultFormMessage


add :: Eq a => a -> [(a, Int)] -> [(a, Int)]
add x [] = [(x, 1)]
add x ((y, n):rest) = if x == y
    then (y, n+1) : rest
    else (y, n) : add x rest

count_2 :: Eq a => [a] -> [(a, Int)]
count_2 = foldr add []

personForm :: Html -> MForm Handler (FormResult String, Widget)
personForm extra = do
    (firstNumRes, firstNumView) <- mreq textField "this is not used" Nothing
    let str = unpack <$> firstNumRes
    let r = count_2 <$> str
    let result = show <$> r
    
    let widget = do
            toWidget
                [lucius|
                    body{
                        background-color: rgba(73, 163, 110, 0.637);
                        font-family:'Open Sans', sans-serif;
                        margin: 0;
                        padding: 0;
                    }
                    header h1{
                        font-family: 'Bebas Neue', cursive;
                        margin: 0;
                        margin-top: 20px;
                        font-size: 25px;
                        line-height: 40px;
                        letter-spacing: 2.70937px;
                        font-weight: normal;
                        color:#fff;
                        text-align: center;
                    } 
                    header h2{
                        text-decoration: none;
                        font-family: 'Bebas Neue', cursive;
                        margin-top: 20px;
                        font-size: 20px;
                        line-height: 20px;
                        letter-spacing: 2.70937px;
                        text-align: center;
                        color:#fff;
                    }       
                    .ts1 p{
                        font-family: 'Bebas Neue', cursive;
                        margin-bottom: 20px;
                        font-size: 18px;
                        line-height: 20px;
                    }
                    .task{
                        font-family: 'Bebas Neue', cursive;
                        margin-bottom: 20px;
                        font-size: 18px;
                        line-height: 20px;
                        font-style: Italic;
                    }

                    .button{
                        width: 250px;
                        height: 40px;
                        font-family:'Open Sans', sans-serif;
                        background: rgba(53, 116, 79, 0.637);
                        letter-spacing: 0.5px;
                        color: #fff;
                        font-weight: 700;
                        font-size: 17px;
                        margin: 15px auto;
                    }
                    .button:hover{
                        background:rgba(73, 163, 110, 0.637);
                        color: #fff;
                     }  
                |]
            [whamlet|
                #{extra}
                <p class="task">
                    Введіть символи: #
                    ^{fvInput firstNumView}
                    \. #
                    <input type=submit value="Результат" class="button">
            |]
    return (result, widget)

getRootR :: Handler Html
getRootR = do
    ((res, widget), enctype) <- runFormGet personForm    
    defaultLayout
        [whamlet|
          <header>
              <h1>Лабораторна робота 5.2
              <h2>Виконала студентка групи КН-31 Ківачук Інна
          <div class="ts1">
            <p> Завдання 1: Визначити частоту кожного елемента списку, напр.: ("aaabbcaadddd") -> [('a',5), ('b',2), ('c',1), ('d',4)].
          <p>Результат: #{show res}
              <form enctype=#{enctype}>
                  ^{widget}
        |]

main :: IO ()
main = warp 3000 MFormExample

-- runHaskell LR_2.hs