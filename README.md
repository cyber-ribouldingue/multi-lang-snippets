# multi-lang-snippets

Ce dépôt a pour but de fournir des **exercices** et un **système de correction automatique** via GitHub Actions.

## Structure du dépôt

- `.github/workflows/validate_snippets.yml` : fichier de configuration pour GitHub Actions (compile et teste le code automatiquement).
- `snippets/` : l'élève met ses snippets / solutions *en cours* dans ce dossier (par exemple `snippets/c/exo1.c`).
- `solutions/` : répertoire contenant les solutions officielles (pour référence ou comparaison).
- `scripts/` : scripts qui compilent ou exécutent les snippets, et comparent les résultats.
- `tests/` : contient les tests pour chaque exercice.

## Comment déposer une solution ?

1. **Fork** ce dépôt ou clonez-le (selon la méthode souhaitée).
2. Dans le répertoire `snippets/<langage>/`, placez votre fichier. 
   - Par exemple, pour l'exercice 1 en C, créez/renseignez `snippets/c/exo1.c`.
3. Poussez vos modifications sur GitHub ou soumettez une Pull Request (PR).
4. Le pipeline GitHub Actions se lancera automatiquement et vérifiera :
   - La compilation,
   - L'exécution,
   - Les tests éventuels (unitaires, comparaison de sortie, etc.).
5. Vous verrez les **résultats** directement dans l'onglet "Actions" de GitHub, ou dans la discussion de la PR (si configuré).

## Exécution locale (facultative)

- Pour **C**, vous pouvez exécuter :  
  ```bash
  bash scripts/compile_run_c.sh
