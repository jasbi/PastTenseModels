# PastTenseModels
Computational Models of The Past Tense Debate

### Repo structure
```
data/
├── claude/
│   ├── README.md
|   ├── excluded_non_verbs.txt
│   └── verbs_with_past_tense.csv
├── add_missing_transcription.ipynb
├── celexToIPA.py
├── child_eng_verbs_isil.R
├── english_merged.txt
├── parent_eng_verbs_isil.R
├── Proportion of verbs in tokens by children.Rmd
├── README.md
├── verb_tokens_large.csv
├── verb_tokens_small.csv
├── verb_tokens_transcribed_full.csv
├── verb_tokens_transcribed_ipa.csv
├── verb_tokens_transcribed.csv
├── verbExtraction.Rmd
└── verbs_not_in_CELEX.txt
```

## Directory Overview

Data for modeling is stored in `verb_tokens_transcribed_full.csv`. 

Columns of interest include 'stem', 'stem_ipa', 'past_tense', 'past_tense_ipa', 'past_tense_type'.

### Background/History

We first worked off of `verbExtraction.Rmd` and Isil's R files (`child_eng_verbs_isil.R` and `parent_eng_verbs_isil.R`). These files compiled words tagged as verbs from CHILDES-DB
that were produced by children (ages 0;0 to 7;0) and their caretakers.

`celexToIPA.py` was then created to merge the IPA transcriptions for the verbs found in CHILDES based on the transcriptions in `english_merged.txt`. The CSV files `verb_tokens_large.csv`, `verb_tokens_small.csv`, `verb_tokens_transcribed.csv` and
`verb_tokens_transcribed_ipa.csv` were then created.

We then ran into issues where CELEX did not have all the verbs that were in CHILDES. We also noticed other issues such as non-verbs that were tagged and English vs NA english transcription. 

Because English and NA English do not have wild differences in past tense, we disregard this issue.

For all other issues, we turned to Claude. See `add_missing_transcription.ipynb` and the README in `/claude` for more details.

### Set up & Install (not tested)

1. Open a terminal and navigate to the directory containing this script.
2. (Optional) Create and activate a virtual environment:
```
        python3 -m venv venv
        source venv/bin/activate
```
3. Ensure you have the required packages installed:
```
        pip install -r requirements.txt
```
4. Make sure "verb_tokens_transcribed.csv" is present in the same directory (or update the INPUT_CSV variable).
5. Run the script using:
```
        python celexToIPA.py
```
6. The script will generate "verb_tokens_transcribed_ipa.csv" with IPA columns. :)
7. Deactivate the virtual environment:
```
        deactivate
```
