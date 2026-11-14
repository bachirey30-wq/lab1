#!/usr/bin/env bash
# Structural submission check.
# Verifies that every required file exists, is not empty, and no longer
# contains unfinished TODO markers from the starter code.
#
# It does NOT grade correctness - your instructor reviews that by hand.

set -u
MIN_BYTES=${MIN_BYTES:-40}
missing=0
empty=0
todo=0

echo "Checking submission structure..."
echo

while IFS= read -r f; do
  [ -z "$f" ] && continue
  case "$f" in \#*) continue ;; esac

  if [ ! -f "$f" ]; then
    printf '  MISSING    : %s\n' "$f"
    missing=$((missing+1))
    continue
  fi

  if [ "$(wc -c < "$f")" -lt "$MIN_BYTES" ]; then
    printf '  EMPTY      : %s  (under %s bytes)\n' "$f" "$MIN_BYTES"
    empty=$((empty+1))
    continue
  fi

  n=$(grep -cE 'TODO|\[fill in\]' "$f" 2>/dev/null || true)
  [ -z "$n" ] && n=0
  if [ "$n" -gt 0 ]; then
    printf '  UNFINISHED : %s  (%s TODO marker(s) left, e.g. TODO or [fill in])\n' "$f" "$n"
    todo=$((todo+1))
  else
    printf '  OK         : %s\n' "$f"
  fi
done < .submission-files

echo
if [ "$missing" -gt 0 ] || [ "$empty" -gt 0 ] || [ "$todo" -gt 0 ]; then
  echo "Result: $missing missing, $empty empty, $todo still unfinished."
  echo "Complete every required file and remove the TODO markers before your final push."
  exit 1
fi
echo "Result: all required files are present and complete. Well done."
