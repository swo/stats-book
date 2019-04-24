import::from(MASS, fractions)
import::from(janitor, round_to_fraction)

"darwin" <-
structure(list(pot = c(1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 
4, 4), crossed = c(23.5, 12, 21, 22, 19.125, 21.5, 22.125, 20.375, 
18.25, 21.625, 23.25, 21, 22.125, 23, 12), self = c(17.375, 20.375, 
20, 20, 18.375, 18.625, 18.625, 15.25, 16.5, 18, 16.25, 18, 12.75, 
15.5, 18)), .Names = c("pot", "crossed", "self"), 
class = "data.frame", row.names = c("1", "2", "3", "4", "5", 
"6", "7", "8", "9", "10", "11", "12", "13", "14", "15"))

my.fraction <- function(x) {
  ones <- floor(x)
  remainder <- x - ones

  if (remainder == 0) {
    as.character(ones)
  } else {
    frac <- as.character(fractions(remainder))
    parts <- str_split(frac, '/')[[1]]
    stopifnot(length(parts) == 2)

    str_interp("${ones} \\tfrac{${parts[1]}}{${parts[2]}}")
  }
}


darwin %>%
  mutate(
    crossedf = map_chr(crossed, my.fraction),
    selff = map_chr(self, my.fraction)
  ) %>%
  str_glue_data("{1:nrow(.)} & {pot} & ${crossedf}$ & ${selff}$ //")
