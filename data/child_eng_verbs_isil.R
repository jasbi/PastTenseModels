library(childesr)
library(dplyr)

# Get all child tokens
child_eng_prod <- get_tokens(
  collection = c("Eng-NA", "Eng-UK"),
  role       = "target_child",
  token      = "*"   # required to retrieve all tokens
)

# Keep only verbs produced by children
child_eng_verbs <- child_eng_prod %>%
  filter(part_of_speech == "v")

# Inspect result
str(child_eng_verbs)

