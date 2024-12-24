#!/usr/bin/env bash

# tests/c/tests_exo1_c.sh

# On s'attend à la sortie "La somme est 5"

gcc -o exo1 snippets/c/exo1.c
output=$(./exo1)
if [ "$output" = "La somme est 5" ]; then
  echo "Test exo1 C: OK"
else
  echo "Test exo1 C: ECHEC - sortie obtenue: '$output'"
fi

rm -f exo1

