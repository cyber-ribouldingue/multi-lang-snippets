#!/usr/bin/env bash

# Compare la sortie d'un snippet et de la solution (pour C, par ex.)
# (Script très simplifié juste à titre d'exemple.)

for file in snippets/c/*.c; do
  [ -e "$file" ] || continue
  base=$(basename "$file" .c)
  
  echo "Comparaison snippet vs solution pour $base"

  # Compiler et exécuter le snippet
  gcc -o "$base" "$file"
  ./"$base" > "student_$base.out"

  # Compiler et exécuter la solution
  gcc -o "${base}_sol" "solutions/c/${base}_solution.c"
  ./"${base}_sol" > "official_$base.out"

  echo "DIFF :"
  diff "student_$base.out" "official_$base.out" || true

  # Nettoyage
  rm -f "$base" "${base}_sol" "student_$base.out" "official_$base.out"
done
