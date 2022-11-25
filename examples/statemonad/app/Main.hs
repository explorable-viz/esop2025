{-# OPTIONS_GHC -Wno-noncanonical-monad-instances #-}
module Main where

import Data.List
import Data.Char (toUpper)
import Data.Ratio ((%))
import Text.Read
import GHC.Base (VecElem(DoubleElemRep))
import GHC.Conc (retry)
import GHC.IO.Encoding (latin1)
import Control.Monad
main :: IO ()
main = putStrLn "Write thy string" >> fmap shout getLine >>= putStrLn 

shout :: [Char] -> [Char]
shout = map toUpper

elementNeg :: [Int] -> [Int]
elementNeg xs = map (* (-1)) xs


divisors :: Integral a => a -> [a]
divisors p = [f | f <- [1..p], p `mod` f == 0]

listDivisors :: Integral a => [a] -> [[a]]
listDivisors xs = map divisors xs

rle :: Eq a => [a] -> [(Int, a)]
rle s = map (\x -> (length x, head x)) (group s)

rld :: [(Int, a)] -> [a]
rld xs = concat (map (uncurry replicate)  xs)

and :: [Bool] -> Bool
and xs = foldr (&&) True xs

or :: [Bool] -> Bool
or = foldr1 (||)

maximum :: Ord a => [a] -> a
maximum xs = foldr1 max xs

mScanr :: (a -> b -> b) -> b -> [a] -> [b]
mScanr f acc xs = foldr f' [acc] xs
    where 
        f' a b = (f a (head b)) : b  

-- mScanl :: (a -> b -> a) -> a -> [b] -> [a]
-- mScanl f acc xs = foldl f' [acc] xs
--     where 
--         f' :: b -> [a] -> b
--         f' b (a:as) = (f a b) : f' b as
--         f' b [] = []

-- listFact :: (Num b, Enum b) => b -> [b]
-- listFact x = 
--     mScanl (*) 1 [1..x]

returnDivisible :: Int -> [Int] -> [Int]
returnDivisible x xs = filter (\y -> y `mod` x == 0) xs

pairOff :: Int -> Either String Int
pairOff ppl
    | ppl < 0 = Left "cant pair off negatives"
    | ppl > 30 = Left "Too many people"
    | even ppl = Right (ppl `div` 2)
    | otherwise = Left "can't pair off odd"

interactiveDoubling = do
    putStrLn "Choose a number: "
    s <- getLine 
    let mx = readMaybe s :: Maybe Double
    case mx of
        Just x -> putStrLn ("The double of your number is " ++ show (2*x))
        Nothing -> do
            putStrLn "this is not a valid number, retrying"
            interactiveDoubling

interactiveSumming :: IO ()
interactiveSumming = do
    putStrLn "Choose 2 numbers: "
    sx <- readMaybe <$> getLine
    sy <- readMaybe <$> getLine
    case (+) <$> sx <*> sy :: Maybe Double of
        Just z -> putStrLn ("The sum of your numbers is " ++ show z)
        Nothing -> do
            putStrLn "Invalid number retrying"
            interactiveSumming

interactiveConcat = do
    putStrLn "Choose two strings"
    sz <- (++) <$> getLine <*> (take 3 <$> getLine)
    putStrLn sz

themselvesTimes :: [Int] -> [Int]
themselvesTimes xs = 
    --concat (map (\x -> replicate x x) xs)
    xs >>= (\x -> replicate x x)

nameDo :: IO String
nameDo = do putStr "First name: "
            first <- getLine 
            putStr "Last name: "
            second <- getLine
            let full = first ++ " " ++ second
            putStrLn ("Pleased to meet you " ++ full)
            return full

data TurnstileState = Locked | Unlocked deriving (Eq, Show)
data TurnstileOutput = Thank | Open | Tut deriving (Eq, Show)

coin, push :: TurnstileState -> (TurnstileOutput, TurnstileState)
coin _ = (Thank, Unlocked)
push Unlocked = (Open, Locked)
push Locked = (Tut, Locked)

monday :: TurnstileState -> ([TurnstileOutput], TurnstileState)
monday s0 =
    let (a1, s1) = coin s0
        (a2, s2) = push s1
        (a3, s3) = push s2
        (a4, s4) = coin s3
        (a5, s5) = push s4
    in ([a1, a2, a3, a4, a5], s5)

regularPerson, distractedPerson, hastyPerson :: TurnstileState -> ([TurnstileOutput], TurnstileState)

regularPerson s0 = 
    let (a1, s1) = coin s0
        (a2, s2) = push s1
    in ([a1, a2], s2)

distractedPerson s0 = 
    let (a1, s1) = coin s0
    in
        ([a1], s1) 

hastyPerson s0 = 
    let (a1, s1) = push s0
    in
        case a1 of
            Open -> ([a1], s1)
            _    -> let (a2, s2) = coin s1
                        (a3, s3) = push s2
                    in 
                        ([a1,a2,a3], s3)

tuesday :: TurnstileState -> ([TurnstileOutput], TurnstileState)
tuesday s0 = 
    let (a1, s1) = regularPerson s0
        (a2, s2) = hastyPerson s1
        (a3, s3) = distractedPerson s2
        (a4, s4) = hastyPerson s3
    in 
        (a1 ++ a2 ++ a3 ++ a4, s4)

newtype State s a = State { runState :: s -> (a, s)}

state :: (s -> (a, s)) -> State s a
state = State

instance Functor (State s) where
    fmap = liftM

instance Applicative (State s) where
    pure = return
    (<*>) = ap

instance Monad (State s) where
    return x = State (\ s -> (x, s))
    -- p >>= k = q where
    --     p' = runState p
    --     k' = runState . k
    --     q' s0 = (y, s2) where
    --         (x, s1) = p' s0
    --         (y, s2) = k' x s1
    --     q = state q'
    p >>= k = state $ \s0 ->
        let (x, s1) = runState p s0
        in runState (k x) s1

compose :: (s -> (a, s)) -- First function
        -> (a -> (s -> (b, s))) -- second function
        -> s -- initial state
        -> (b, s) -- output and final state
compose f g = \s0 -> let (a1, s1) = f s0 in (g a1) s1

coinS, pushS :: State TurnstileState TurnstileOutput
--coinS = state (\_ ->(Thank, Unlocked))

mondayS :: State TurnstileState [TurnstileOutput]
mondayS = sequence [coinS, pushS, pushS, coinS, pushS]

regularPersonS :: State TurnstileState [TurnstileOutput]
regularPersonS = sequence [coinS, pushS]

distractedPersonS :: State TurnstileState TurnstileOutput
distractedPersonS = coinS

hastyPersonS :: State TurnstileState [TurnstileOutput]
hastyPersonS = do
    a1 <- pushS
    case a1 of
        Open -> return [a1]
        _ -> do 
            a2 <- coinS
            a3 <- pushS
            return [a1, a2, a3]

evalState :: State s a -> s -> a
evalState p s = fst (runState p s)

execState :: State s a -> s -> s
execState p s = snd (runState p s)

testTurnstile :: State TurnstileState Bool
testTurnstile = do
    put Locked
    check1 <- pushS
    put Unlocked
    check2 <- pushS
    put Locked
    return (check1 == Tut && check2 == Open)

put :: s -> State s ()
put newState = state $ \_ -> ((), newState)

get :: State s s
get = state $ \s -> (s, s)

pushS  = do
    s <- Main.get
    put Locked
    case s of 
        Locked -> return Tut
        Unlocked -> return Open

coinS = do
    put Unlocked
    return Thank

data TurnstileInput = Coin | Push deriving (Eq, Show)

turnS :: TurnstileInput -> State TurnstileState TurnstileOutput
turnS = State . turn where
    turn Coin _ = (Thank, Unlocked)
    turn Push Unlocked = (Open, Locked)
    turn Push Locked = (Tut, Locked)

getsThroughS :: TurnstileInput -> State TurnstileState Bool
getsThroughS input = do
    output <- turnS input
    return $ output == Open

countOpens :: [TurnstileInput] -> State TurnstileState Int
countOpens = foldM incIfOpen 0 where
    incIfOpen :: Int -> TurnstileInput -> State TurnstileState Int
    incIfOpen n i = do
        g <- getsThroughS i
        if g then return (n+1) else return n