Write-Host "=== Compilation C sous Windows ==="

# Exemple très simple : compiler tous les .c de snippets\c\ en utilisant le compilateur MSVC (cl.exe)
# Note: cl.exe est pré-installé sur windows-latest, mais vous devrez peut-être exécuter Developer Command Prompt.
# Ici on suppose que cl.exe est dans le PATH.

$ResultFile = "results_c.csv"
"Fichier,Statut" | Out-File $ResultFile

# Parcours des fichiers .c dans snippets/c
Get-ChildItem -Path snippets\c\*.c | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name
    $baseName = [IO.Path]::GetFileNameWithoutExtension($fileName)
    
    Write-Host "Compiling $filePath..."
    cl.exe /EHsc /Fe$baseName.exe $filePath
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation OK : $baseName.exe"
        
        # Exécution
        .\$baseName.exe
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Exécution OK"
            "$filePath,OK" | Out-File $ResultFile -Append
        }
        else {
            Write-Host "Exécution ERROR"
            "$filePath,ERREUR_EXECUTION" | Out-File $ResultFile -Append
        }

        # Nettoyage
        Remove-Item .\$baseName.exe -Force
    }
    else {
        Write-Host "Compilation FAILED"
        "$filePath,ERREUR_COMPILATION" | Out-File $ResultFile -Append
    }
}
