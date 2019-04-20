import System.Random

main = putStrLn $ show numbers
    where numbers = map fst pairs
          -- get the first 10 pairs on numbers and generators
          pairs = take 10 allPairs
          allPairs = iterate f (0, gen)
          -- a function that generates a new (value, gen) pair and takes out the gen
          f = randomR (0.0 :: Double, 1.0 :: Double) . snd
          -- make a rng with seed 1 
          gen = mkStdGen 1
