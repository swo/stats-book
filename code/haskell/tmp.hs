import Data.List (sortBy)
import Text.Printf (printf)

differences :: [Double]
differences = [1, 2, 3]

population :: [[Double]]
population = f differences [[]]
    where f [] ys = ys
          f (x:xs) ys = [(x:), (-x:)] <*> (f xs ys)

main = putStrLn $ show $ population
