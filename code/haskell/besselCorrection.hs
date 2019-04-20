import System.Random

-- Box-Muller transform takes two iid U(0, 1) random numbers and transforms them
-- to two iid N(0, 1) random numbers
boxMuller :: (Double, Double) -> (Double, Double)
boxMuller (u1, u2) = (r * (cos theta), r * (sin theta))
    where r = sqrt ((-2) * (log u1))
          theta = 2 * pi * u2

-- Given a seed, iid uniform [0, 1] random numbers
randomUniform :: Int -> [Double]
randomUniform seed = tail numbersWithPlaceholder
    where numbersWithPlaceholder = map fst pairs
          pairs = iterate f (0, gen) -- the zero is just a placeholder
          f = randomR (0.0, 1.0) . snd
          gen = mkStdGen seed

-- Given a seed, n iid N(0, 1) random numbers
randomNormal :: Int -> [Double]
randomNormal seed = map fst normalPairs
    where normalPairs = map boxMuller uniformPairs
          uniformPairs = pairs $ randomUniform seed
          pairs [] = []
          pairs (x:y:zs) = (x, y) : pairs zs

mean :: Fractional a => [a] -> a
mean xs = (sum xs) / (fromIntegral (length xs))

variance :: Fractional a => [a] -> a
variance xs = (sum squareDeviations) / (fromIntegral (length xs))
    where squareDeviations = [(x - mean xs) ^ 2 | x <- xs]

sampleVariance :: Fractional a => [a] -> a
sampleVariance xs = n / (n + 1) * variance xs
    where n = fromIntegral $ length xs

main = do
    putStrLn "take 3 random numbers, compute the variance, repeat 100 times, and take mean"
    putStrLn $ show $ mean $ [variance (take 3 $ randomNormal seed) | seed <- [1..1000]]
    putStrLn "and think about multiplying that by 3/2"
