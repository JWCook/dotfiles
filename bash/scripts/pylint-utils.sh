#!/usr/bin/env bash
# Utilities for processing python linting rules for pylint, flake8, and SonarQube
# Requires xmlstarlet and pylint

PYLINT_MSGS_PATTERN=":([a-z-]+) \(([[:alnum:]]+)\).*"
PYLINT_CODE_PATTERN="^[A-RT-Z][[:digit:]]+$"
SONAR_CODE_PATTERN="^S[[:digit:]]+$|^format$|^max(imum)?$|^threshold$"

# Get mappings from pylint rule codes to human-readable names
pylint-list-msgs-dict() {
    pylint --list-msgs | sed -rn "s/${PYLINT_MSGS_PATTERN}/\2:\1/pg"
}

# Get sed script to replace pylint rule codes with human-readable names
pylint-list-msgs-script() {
    pylint --list-msgs | sed -rn "s/${PYLINT_MSGS_PATTERN}/s\/\2\/\1\/g/pg"
}

# Replace pylint rule codes with human-readable names
pylint-translate-codes() {
    pylint-list-msgs-script | sed -f - "$@" | sort
}

# Extract rules from SonarQube quality profile
# From SonarQube UI: 'Quality Profiles' -> find profile -> 'Back Up'
# Usage: get-sonar-rules [input-file] [output-file]
get-sonar-rules() {
    IN_FILE=${1:-sonarqube_profile.xml}
    OUT_FILE=${2:-sonarqube_rules.txt}
    TMP_FILE=$(mktemp)
    echo "Reading $IN_FILE..."

    # Extract all rule keys from profile, and translate to rule codes to names
    xmlstarlet sel -t -v '//key' -n $IN_FILE > $TMP_FILE
    pylint-translate-codes -i $TMP_FILE

    # Sort rules, move untranslated codes to end of file, and omit SonarQube-specific rules
    sort -o $TMP_FILE $TMP_FILE
    grep -Ev "$PYLINT_CODE_PATTERN|$SONAR_CODE_PATTERN" $TMP_FILE > $OUT_FILE
    grep -E "$PYLINT_CODE_PATTERN" $TMP_FILE >> $OUT_FILE

    rm $TMP_FILE
    echo "$(cat sonarqube_rules.txt | wc -l) rules written to $OUT_FILE"
}

pylint-rules-to-pylintrc() {
    printf "enable="; sed -z 's/\n/\,\n    /g' $1
}
