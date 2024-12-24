Write-Host "=== Compilation C sous Windows ==="

$ResultFile = "results_c.csv"
"Fichier,Statut" | Out-File $ResultFile

# Parcours des fichiers .c dans snippets/c
Get-ChildItem -Path "snippets\c\*.c" | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name
    $baseName = [IO.Path]::GetFileNameWithoutExtension($fileName)
    
    Write-Host "Compiling $filePath..."

    # IMPORTANT: guillemets autour des arguments
    gcc -o "$baseName.exe" "$filePath"

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation OK : $baseName.exe"
        
        .\$baseName.exe
        if ($LASTEXITCODE -eq 0) {
            "$filePath,OK" | Out-File $ResultFile -Append
        }
        else {
            "$filePath,ERREUR_EXECUTION" | Out-File $ResultFile -Append
        }

        Remove-Item ".\$baseName.exe" -Force
    }
    else {
        Write-Host "Compilation FAILED"
        "$filePath,ERREUR_COMPILATION" | Out-File $ResultFile -Append
    }
}
