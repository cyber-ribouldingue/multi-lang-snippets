Write-Host "=== Compilation C sous Windows ==="

$ResultFile = "results_c.csv"
"Fichier,Statut,Détails" | Out-File $ResultFile

# On parcourt tous les .c dans le dossier snippets\c
Get-ChildItem -Path "snippets\c\*.c" | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name
    $baseName = [IO.Path]::GetFileNameWithoutExtension($fileName)
    
    Write-Host "Compiling $filePath..."

    # Redirection de la sortie standard et erreur vers compile.log
    gcc -o "$baseName.exe" "$filePath" > compile.log 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation OK : $baseName.exe"

        # Exécution
        .\$baseName.exe > run.log 2>&1
        if ($LASTEXITCODE -eq 0) {
            # OK
            "$filePath,OK," | Out-File $ResultFile -Append
        }
        else {
            # Erreur d'exécution
            $details = Get-Content run.log | Select-Object -First 1
            "$filePath,ERREUR_EXECUTION,$details" | Out-File $ResultFile -Append
        }

        Remove-Item ".\$baseName.exe" -Force
        Remove-Item run.log -ErrorAction SilentlyContinue
    }
    else {
        # Erreur de compilation
        $details = Get-Content compile.log | Select-Object -First 1
        Write-Host "Compilation FAILED"
        "$filePath,ERREUR_COMPILATION,$details" | Out-File $ResultFile -Append
    }
}

Remove-Item compile.log -ErrorAction SilentlyContinue
