import Data.List (sortBy)
import Text.Printf (printf)

-- The actual data
differences :: [Double]
differences = [6.125, -8.375, 1, 2, 0.75, 2.875, 3.5, 5.125, 1.75, 3.625, 7, 3, 9.375, 7.5, -6]

-- The population to be sampled from. It's all 2^N ways of slipping the signs
-- in the actual data.
population :: [[Double]]
population = f differences [[]]
    where f [] ys = ys
          f (x:xs) ys = [(x:), (-x:)] <*> (f xs ys)

-- Count number of positive signs
signStatistic :: [Double] -> Int
signStatistic = length . filter (>0)

-- Count the sum of the ranks that have associated positive differences
wilcoxonT :: [Double] -> Int
wilcoxonT xs = sum plusRs
    where plusRs = [r | (r, s) <- rankSigns, s == 1]
          -- make pairs [(1, smallest diff), (2, second smallest), etc.]
          rankSigns = zip [1..] (map signum sortedDiffs)
          -- sort the diffs according to their absolute values
          sortedDiffs = sortBy (\x y -> compare (abs x) (abs y)) xs

-- Count the sum of the signed ranks. Similar to above, but note that
-- signum returns the same type as it took in, so we need to convert that
-- to an integer to multiple by the rank.
wilcoxonW :: [Double] -> Int
wilcoxonW xs = sum signedRanks
    where signedRanks = [r * s | (r, s) <- rankSigns]
          rankSigns = zip [1..] (map (round . signum) sortedDiffs)
          sortedDiffs = sortBy (\x y -> compare (abs x) (abs y)) xs

-- What fraction of elements in the list satisfy the predicate?
proportionWhere :: (a -> Bool) -> [a] -> Double
proportionWhere f xs = fromIntegral num / fromIntegral den
    where num = length $ filter f xs
          den = length xs

-- Given a statistic for summarizing a case, and given the universe of
-- possible cases and the observed case, what fraction of cases in the
-- universe have a statistic as extreme as the one observed?
pValue :: (Ord b, Num b) => (a -> b) -> [a] -> a -> Double
pValue statistic population observed = proportionWhere (>= obsStat) popStats
    where obsStat = statistic observed
          popStats = map statistic population

main = do
    putStrLn $ printf "binomial test: %.8f" $ pValue signStatistic population differences
    putStrLn $ printf "Wilcoxon T: %.8f" $ pValue wilcoxonT population differences
    putStrLn $ printf "Wilcoxon W: %.8f" $ pValue wilcoxonW population differences
    putStrLn $ printf "Fisher sum: %.8f" $ pValue sum population differences
