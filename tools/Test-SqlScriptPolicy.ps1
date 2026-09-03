[CmdletBinding()]
param([string]$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path)

$ErrorActionPreference = 'Stop'
$excluded = @('99-Quarantine', '00-Start-Here\Organization-Audit-Artifacts')
$files = Get-ChildItem -LiteralPath $Root -Recurse -File -Include *.sql,*.ps1,*.bat,*.txt |
    Where-Object { $relative = [IO.Path]::GetRelativePath($Root, $_.FullName); $_.Name -ne 'Test-SqlScriptPolicy.ps1' -and -not ($excluded | Where-Object { $relative.StartsWith($_, [StringComparison]::OrdinalIgnoreCase) }) }

$rules = [ordered]@{
    'Possible plaintext password assignment' = '(?i)(password|pwd|secret)\s*=\s*[''\"][^$<][^''\"]{3,}[''\"]'
    'Hardcoded SQL authentication password' = '(?i)PASSWORD\s*=\s*[''\"][^$<][^''\"]+[''\"]'
    'Potential private key' = '-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----'
    'Destructive DROP DATABASE' = '(?i)\bDROP\s+DATABASE\b'
    'Destructive TRUNCATE TABLE' = '(?i)\bTRUNCATE\s+TABLE\b'
    'Instance cache clearing' = '(?i)DBCC\s+(FREEPROCCACHE|DROPCLEANBUFFERS)'
    'xp_cmdshell usage' = '(?i)\bxp_cmdshell\b'
}

$findings = @()
foreach ($file in $files) {
    $content = Get-Content -Raw -LiteralPath $file.FullName -ErrorAction SilentlyContinue
    if ($null -eq $content) { continue }
    $relative = [IO.Path]::GetRelativePath($Root, $file.FullName)
    foreach ($rule in $rules.GetEnumerator()) {
        $isSecretRule = $rule.Key -like '*password*' -or $rule.Key -like '*private key*'
        $isProductionCandidate = $relative.StartsWith('20-Production-Candidates', [StringComparison]::OrdinalIgnoreCase)
        if (-not $isSecretRule -and -not $isProductionCandidate) { continue }
        if ($content -match $rule.Value) {
            $findings += [pscustomobject]@{ Rule = $rule.Key; File = $relative }
        }
    }
}

if ($findings.Count -gt 0) {
    $findings | Sort-Object Rule, File | Format-Table -AutoSize | Out-String | Write-Host
    Write-Error "SQL script policy failed with $($findings.Count) finding(s). Move unsafe files to quarantine or document and suppress through reviewed policy changes."
}

Write-Host "SQL script policy passed for $($files.Count) readable candidate files."
