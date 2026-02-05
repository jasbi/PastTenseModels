library(childesr)
library(dplyr)
library(stringr)
library(readr)

# -----------------------------
# 1) Load verb list (tab-delimited, no header)
# -----------------------------
ref_path <- "/Users/isildogan/Desktop/english_merged.txt"
#I got this list from RevisitPinkerAndPrince
ref <- read_tsv(
  ref_path,
  col_names = c("verb_base", "verb_past", "ipa_base", "ipa_past", "reg_status"),
  show_col_types = FALSE,
  quote = ""
)

# Build a set of verb "stems" (base forms)
verb_stems <- ref %>%
  mutate(verb_base = str_to_lower(str_trim(verb_base))) %>%
  filter(!is.na(verb_base), verb_base != "") %>%
  pull(verb_base) %>%
  unique()

# Helper: normalize tokens for matching
norm <- function(x) {
  x %>%
    str_to_lower() %>%
    str_trim() %>%
    # keep letters + apostrophes, drop punctuation/spaces
    str_replace_all("[^a-z']", "") %>%
    na_if("")
}

# -----------------------------
# 2) Pull ALL child tokens
# -----------------------------
child_tokens <- get_tokens(
  collection = c("Eng-NA", "Eng-UK"),
  role       = "target_child",
  token      = "*"
)

# -----------------------------
# 3) Keep verbs:
#   - POS-coded verbs (part_of_speech == "v")
#   - OR missing POS, but token stem/gloss matches verb_stems
# -----------------------------
child_verbs <- child_tokens %>%
  mutate(
    pos_norm   = str_to_lower(str_trim(part_of_speech)),
    pos_missing = is.na(pos_norm) | pos_norm == "",
    
    stem_norm  = norm(stem),
    gloss_norm = norm(gloss),
    
    # use stem if available; otherwise gloss
    match_key  = coalesce(stem_norm, gloss_norm),
    
    in_verb_list = !is.na(match_key) & match_key %in% verb_stems
  ) %>%
  filter(
    pos_norm == "v" |
      (pos_missing & in_verb_list)
  )

# Inspect
str(child_verbs)

# Optional: how many came from POS vs "rescued" via verb list?
child_verbs %>%
  mutate(source = if_else(str_to_lower(str_trim(part_of_speech)) == "v",
                          "POS=v", "rescued_by_verb_list")) %>%
  count(source)
