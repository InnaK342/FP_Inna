{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Yesod
import Control.Applicative
import Data.Text (Text)

data MFormExample = MFormExample

mkYesod "MFormExample" [parseRoutes|
/ RootR GET
|]

instance Yesod MFormExample

instance RenderMessage MFormExample FormMessage where
  renderMessage _ _ = defaultFormMessage

divis :: Integral a => a -> [a]
divis n = [x | x <- [2..n], [z | z <- [2 .. x-1], x `mod` z == 0] == [], mod n x == 0]

personForm :: Html -> MForm Handler (FormResult [Int], Widget)
personForm extra = do
    (firstNumRes, firstNumView) <- mreq intField "this is not used" Nothing
    
    let result = divis <$> firstNumRes 
    
    let widget = do
            toWidget
                [lucius|
                    ##{fvId firstNumView} {
                        width: 3em;
                    }
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
                    Введіть число: #
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
            <p> Завдання 1: Знайти простi дiльники числа.
          <p>Результат: #{show res}
              <form enctype=#{enctype}>
                  ^{widget}
        |]

main :: IO ()
main = warp 3000 MFormExample

-- runHaskell LR.hs