"""
celexToIPA.py
Debbie Odufuwa
2026-02-19

Adds IPA transcription columns to verb_tokens_transcribed.csv using phonecodes 2.x.
Reads stem_celex_encoding and past_tense_celex_encoding, converts DISC/CELEX to IPA
with phonecodes (language=English), and writes two new columns: stem_ipa, past_tense_ipa.

Requires: pip install phonecodes>=2.0.0

# Command Line Usage:
#   1. Open a terminal and navigate to the directory containing this script.
#   2. (Optional) Create and activate a virtual environment:
#        python3 -m venv venv
#        source venv/bin/activate
#   3. Ensure you have the required packages installed:
#        pip install "phonecodes>=2.0.0" pandas
#        pip install --upgrade pip
#   4. Make sure "verb_tokens_transcribed.csv" is present in the same directory (or update the INPUT_CSV variable).
#   5. Run the script using:
#        python celexToIPA.py
#   6. The script will generate "verb_tokens_transcribed_ipa.csv" with IPA columns. :)
#   7. Deactivate the virtual environment:
#        deactivate
"""

import pandas as pd
from phonecodes import phonecodes

INPUT_CSV = "verb_tokens_transcribed.csv"
OUTPUT_CSV = "verb_tokens_transcribed_ipa.csv"
LANG = "eng"


def celex_to_ipa(celex_val: str) -> str:
    """Convert a single CELEX/DISC string to IPA. Returns empty string for NA/missing."""
    if pd.isna(celex_val) or celex_val == "" or str(celex_val).strip().upper() == "NA":
        return ""
    s = str(celex_val).strip()
    try:
        return phonecodes.convert(s, "disc", "ipa", LANG)
    except Exception:
        return ""


def main():
    df = pd.read_csv(INPUT_CSV)
    df["stem_ipa"] = df["stem_celex_encoding"].map(celex_to_ipa)
    df["past_tense_ipa"] = df["past_tense_celex_encoding"].map(celex_to_ipa)
    df.to_csv(OUTPUT_CSV, index=False)


if __name__ == "__main__":
    main()
