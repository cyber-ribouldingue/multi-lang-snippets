# multi-lang-snippets

Ce dépôt a pour objectif de proposer des **exercices simples** dans plusieurs langages (C, C++, Python...), avec une **validation automatique** (compilation, exécution, test) sur plusieurs plateformes (Linux, Windows, macOS) grâce à GitHub Actions.  
Il s’agit donc d’un environnement d’**apprentissage** et de **correction** automatisée : l’élève peut y soumettre son code et voir rapidement s’il compile et s’exécute correctement.

---

## Sommaire

1. [Structure du projet](#structure-du-projet)  
2. [Fonctionnement général](#fonctionnement-général)  
3. [Tutoriel pour les élèves](#tutoriel-pour-les-élèves)  
   1. [Récupérer le dépôt](#1-récupérer-le-dépôt)  
   2. [Placer son code](#2-placer-son-code)  
   3. [Tester en local](#3-tester-en-local)  
   4. [Pousser le code sur GitHub / Créer une PR](#4-pousser-le-code-sur-github--créer-une-pr)  
   5. [Lire les résultats et corriger](#5-lire-les-résultats-et-corriger)  
4. [Aller plus loin : personnalisation](#aller-plus-loin--personnalisation)

---

## Structure du projet

Le dépôt présente la structure suivante :
multi-lang-snippets/
├─ .github/ │ └─ workflows/ │ └─ validate_exercises.yml <-- Fichier de configuration GitHub Actions ├─ snippets/ │ ├─ c/ │ │ └─ exo1.c <-- Exemple d'exercice en C │ ├─ cpp/ │ │ └─ exo1.cpp <-- Exemple d'exercice en C++ │ ├─ python/ │ │ └─ exo1.py <-- Exemple d'exercice en Python │ └─ ... <-- Autres langages, exos ├─ solutions/ │ ├─ c/ │ │ └─ exo1_solution.c │ ├─ cpp/ │ │ └─ exo1_solution.cpp │ ├─ python/ │ │ └─ exo1_solution.py │ └─ ... ├─ scripts/ │ ├─ compile_run_c.sh <-- Script de compilation/exécution pour C (Linux/macOS) │ ├─ compile_run_c_windows.ps1 <-- Script pour Windows (PowerShell) │ ├─ test_python.sh <-- Script pour Python │ └─ ... ├─ tests/ │ └─ (potentiellement des tests unitaires ou scripts de test) └─ README.md


- **`.github/workflows/validate_exercises.yml`** : décrit le **pipeline CI** GitHub Actions, qui va compiler et exécuter les snippets sur Linux, Windows et macOS.  
- **`snippets/`** : **le dossier principal** où un élève déposera (ou modifiera) son code pour chaque exercice.  
- **`solutions/`** : fournit des **versions officielles** (ou exemples) de solutions, pour comparaison ou référence.  
- **`scripts/`** : contient les scripts **d’automatisation** (compilation, exécution, etc.).  
- **`tests/`** : optionnel, pour des tests unitaires ou des scripts de validation plus avancés.

---

## Fonctionnement général

1. **L’élève dépose ou modifie** son code dans `snippets/<langage>/`. Par exemple, `snippets/c/exo1.c`.  
2. **À chaque push** (ou pull request) sur GitHub, un **workflow GitHub Actions** se déclenche :  
   - Sur **Ubuntu (Linux)**, **Windows**, et **macOS**, le code est compilé et exécuté.  
   - Les statuts de compilation et d’exécution sont recueillis dans un **tableau récapitulatif** (visible dans l’onglet “Actions” du dépôt).  
3. **L’élève** peut alors consulter ce tableau pour voir :  
   - Si le code compile ou non (ERREUR_COMPILATION, OK, etc.).  
   - Si l’exécution produit un résultat correct ou non (ERREUR_EXECUTION, OK…).  
   - (Éventuellement) la **première ligne** de l’erreur pour un diagnostic rapide.  
4. Si le code **échoue**, l’élève **corrige**, recommitte, et la boucle continue jusqu’à obtention d’un statut satisfaisant.

---

## Tutoriel pour les élèves

### 1) Récupérer le dépôt

Vous avez **plusieurs options** :

- **Cloner** le dépôt en local (via HTTPS ou SSH) :  
  ```bash
  git clone https://github.com/cyber-ribouldingue/multi-lang-snippets.git

      Forker le dépôt sur votre compte GitHub, puis le cloner sur votre machine.

Cette étape vous donne accès au code et aux scripts localement.
2) Placer son code

    Allez dans le dossier snippets/ puis dans le sous-dossier correspondant à votre langage (exemple : snippets/c).
    Ouvrez ou créez le fichier d’exercice (par ex. exo1.c).
    Complétez le code 

    Exemple fictif :
    #include <stdio.h>

// TODO: Calculer la somme de a et b
int main() {
    int a = 5;
    int b = 7;
    printf("La somme est %d\n", a + b);
    return 0;
}

3) Tester en local

    Linux / macOS :
   bash scripts/compile_run_c.sh
   Cela compile tous les fichiers .c du dossier snippets/c/ et génère un fichier results_c.csv contenant le statut (OK,    ERREUR, etc.).

   Windows (PowerShell) :
   .\scripts\compile_run_c_windows.ps1
   Ou utilisez WSL sous Windows pour lancer le script Bash.

   Python :
   bash scripts/test_python.sh
       Cela exécute chaque fichier .py dans snippets/python/ et génère un results_python.csv.

Si la compilation (ou l’exécution) échoue, vous verrez un message d’erreur dans la console. Corrigez avant de pousser sur GitHub.

4) Pousser le code sur GitHub / Créer une PR

    Git add et commit vos changements en local :
   git add snippets/c/exo1.c
git commit -m "exo1.c : première version"
git push origin main
    Sur GitHub, vous pouvez aussi créer une Pull Request (PR) si vous travaillez sur une branche séparée.
    GitHub déclenche alors le workflow : vous verrez une nouvelle entrée dans l’onglet “Actions”.

5) Lire les résultats et corriger

    Dans l’onglet Actions de GitHub, cherchez le job "Validate Exercises (Multi-Platform)".

    Cliquez pour voir le détail des 3 sous-jobs : Ubuntu, Windows, macOS.

    Chaque sous-job compile et exécute. En fin de logs, vous verrez un tableau :
   ## Résultats de la compilation et exécution (ubuntu-latest)
| Fichier                | Statut               | Détails                      |
|------------------------|----------------------|-----------------------------|
| `snippets/c/exo1.c`   | ERREUR_COMPILATION   | expected ';' before 'return'
...
Si vous voyez “ERREUR_COMPILATION” ou “ERREUR_EXECUTION”, corrigez votre code, repoussez, et regardez à nouveau.

Continuez jusqu’à obtenir “OK” partout.


Bonne pratique et bonne correction !

   



