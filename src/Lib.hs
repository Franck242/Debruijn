module Lib
    ( someFunc
    ) where
import System.Environment
import System.Exit
import System.IO
import Control.Monad.Fail
import Control.Monad.Fix
import Control.Monad.ST
import Data.Char

myFact :: Int -> Int
myFact 0 = 1
myFact n = n * myFact (n - 1)

mySqrt :: Float -> Float
mySqrt 0 = 0
mySqrt n = sqrt(n)

myPow :: Int -> Int -> Int
myPow n 0 = 1
myPow n k = n * myPow n (k - 1)

badInput :: IO ()
badInput = do
  hPutStr stderr "Error, too many arguments\n"
  exitWith $ ExitFailure 84

badValue :: IO ()
badValue = do
  hPutStr stderr "Error, argument in the first position must be positive and of right format\n"
  exitWith $ ExitFailure 84

helpFunc :: IO ()
helpFunc = do
  putStrLn "USAGE: ./deBruijn n [a] [--check|--unique|--clean]\n"
  putStrLn "\t--check \t check if a sequence is a Bruijn sequence"
  putStrLn "\t--unique \t chzck if 2 sequences are distinct de Bruijn sequences"
  putStrLn "\t--clean \t list cleanning"
  putStrLn "\tn \t\t order of the sequence"
  putStrLn "\ta \t\t alphabet [def: '01']"
  exitWith ExitSuccess

errorGestion :: [String] -> Int -> IO ()
errorGestion list_arg nbr_args = do
  if nbr_args == 3 then do
    let action = list_arg !! 2
    if action /= "--check" && action /= "--unique" && action /= "--clean" then do 
      hPutStr stderr "Error , bad action specify\n"
      exitWith $ ExitFailure 84
      else return ()
      else return ()
  if nbr_args == 2 then do
    let action = list_arg !! 1
    if action /= "--check" && action /= "--unique" && action /= "--clean" then do 
      hPutStr stderr "Error , bad action specify\n"
      exitWith $ ExitFailure 84
      else return ()
      else return ()

checDebruijnoneinfo :: [String] -> Int -> IO ()
checDebruijnoneinfo arg nbr_args = do
  if nbr_args == 3 then do
            let nb_tmp = arg !! 0
            let check = arg !! 2
            let tmp = arg !! 1
            let l = length tmp
            let nb = read nb_tmp :: Int
            if nb <= 0 then badValue
              else return ()
            if check == "--check" then do
              sequence <- getLine
              let s = length sequence
              if myPow l nb == s then putStrLn "OK"
                else putStrLn "KO"
              else return ()
            else return ()

checDebruijntwoinfo :: [String] -> Int -> IO ()
checDebruijntwoinfo arg_list nbr_args = do
  if nbr_args == 2 then do
            let nb_tmp = arg_list !! 0
            let check = arg_list !! 1
            let nb = read nb_tmp :: Int
            if nb <= 0 then badValue
              else return ()
            if check == "--check" then do
              sequence <- getLine
              let s = length sequence
              if myPow 2 nb == s then putStrLn "OK"
                else putStrLn "KO"
              else return ()
            else return ()

uniqueDebruijn :: [String] -> Int -> IO ()
uniqueDebruijn arg_list nbr_args = do
  if nbr_args == 2 then do
            let nb_tmp = arg_list !! 0
            let unique = arg_list !! 1
            let nb = read nb_tmp :: Int
            if nb <= 0 then badValue
              else return ()
            if unique == "--unique" then do
              sequence <- getLine
              sequence1 <- getLine
              let seq_inv = reverse sequence
              let s = length sequence
              let s1 = length sequence1
              if myPow 2 nb == s && s1 == s && sequence /= sequence1 then putStrLn "OK"
                else putStrLn "KO"
              else return ()
            else return ()

someFunc :: IO ()
someFunc = do
           args <- getArgs
           if null args
            then helpFunc
            else return ()
           let size = length args
           if size > 3 then badInput
            else return ()
           errorGestion args size
           checDebruijnoneinfo args size
           checDebruijntwoinfo args size
           uniqueDebruijn args size