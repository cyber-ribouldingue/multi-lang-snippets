# Multi-Language Snippets Validation

Ce dépôt permet à un élève de soumettre des **extraits de code** (snippets) en **C**, **C++** et **Python**, et de recevoir un **feedback automatique** grâce à GitHub Actions.

## Arborescence

- `.github/workflows/validate_snippets.yml` : Configuration de notre workflow GitHub Actions.
- `snippets/` : Contient les codes fournis par les élèves, organisés par langage.
  - `snippets/c/` : Snippets en C
  - `snippets/cpp/` : Snippets en C++
  - `snippets/python/` : Snippets en Python
- `solutions/` : Contient des exemples de corrections (solutions officielles).
- `scripts/` : Scripts qui compilent ou exécutent les snippets pour en vérifier le bon fonctionnement.
  - `compile_run_c.sh`
  - `compile_run_cpp.sh`
  - `test_python.sh`
- `README.md` : Ce fichier d'explication.

## Comment ça marche ?

1. **Ajouter ou modifier un snippet** :  
   - Placez votre fichier `.c`, `.cpp` ou `.py` dans le dossier correspondant sous `snippets/`.
2. **Commit & Push** (ou ouvrez une Pull Request) :
   - GitHub Actions va se déclencher automatiquement (voir l'onglet "Actions" sur GitHub).
3. **Compilation / Exécution** :  
   - Sur Ubuntu, votre code C/C++ sera compilé (via gcc ou g++).  
   - Votre code Python sera exécuté avec `python`.
4. **Résultats** :  
   - Un tableau de résumé apparaît dans la page GitHub Actions, indiquant pour chaque fichier s'il est **OK**, ou s'il y a eu une **ERREUR_DE_COMPILATION** ou **ERREUR_A_L_EXECUTION**.
   - Un fichier `results_global.csv` est uploadé en **artifact**.
5. **Interpréter les erreurs** :  
   - **ERREUR_DE_COMPILATION** : souvent un problème de syntaxe (point-virgule manquant, etc.).  
   - **ERREUR_A_L_EXECUTION** : le code compile mais plante à l'exécution (ex. segmentation fault, erreur de syntaxe Python, etc.).

## Étendre le projet

- Vous pouvez **ajouter Windows/macOS** dans le workflow en utilisant `runs-on: [ubuntu-latest, windows-latest, macos-latest]` via la matrice de stratégie GitHub Actions.  
- Vous pouvez implémenter des **tests unitaires** plus avancés, par exemple avec `pytest`, `Catch2`, etc.  
- Vous pouvez **comparer** le résultat du snippet à une "solution officielle" ou un "output" attendu.

## Exemple de snippets

- [`snippets/c/snippet1.c`](snippets/c/snippet1.c) : Code C avec une petite erreur de syntaxe.
- [`snippets/cpp/snippet1.cpp`](snippets/cpp/snippet1.cpp) : Code C++ avec un opérateur manquant.
- [`snippets/python/snippet1.py`](snippets/python/snippet1.py) : Petit code Python incorrect.

Bonne validation de code !
