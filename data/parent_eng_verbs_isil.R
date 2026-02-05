library(childesr)
library(dplyr)

# Get all parent tokens
parent_eng_prod <- get_tokens(
  collection = c("Eng-NA", "Eng-UK"),
  role       = c("mother", "father", "caregiver"), #what else should i add here? or just target_parent?
  token      = "*"
)


# Keep only verbs produced by parents
parent_eng_verbs <- parent_eng_prod %>%
  filter(part_of_speech == "v")

# Inspect result
str(parent_eng_verbs)
