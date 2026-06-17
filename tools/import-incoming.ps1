param(
  [string]$IncomingDir = "_incoming",
  [string]$LogosDir = "logos",
  [string]$CatalogPath = "logos.json"
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$incoming = Join-Path $root $IncomingDir
$logos = Join-Path $root $LogosDir
$catalogFile = Join-Path $root $CatalogPath

New-Item -ItemType Directory -Force -Path $incoming | Out-Null
New-Item -ItemType Directory -Force -Path $logos | Out-Null

$allowed = @(".png", ".svg", ".webp", ".jpg", ".jpeg")
$files = Get-ChildItem -Path $incoming -File | Where-Object { $allowed -contains $_.Extension.ToLowerInvariant() }

$catalog = @()
foreach ($file in $files) {
  $id = [IO.Path]::GetFileNameWithoutExtension($file.Name).ToLowerInvariant() -replace '[^a-z0-9]+', '-'
  $id = $id.Trim('-')
  if (-not $id) { continue }

  $destName = "$id$($file.Extension.ToLowerInvariant())"
  $destPath = Join-Path $logos $destName
  Copy-Item -LiteralPath $file.FullName -Destination $destPath -Force

  $displayName = (Get-Culture).TextInfo.ToTitleCase(($id -replace '-', ' '))
  $catalog += [ordered]@{
    id = $id
    name = $displayName
    brand = $displayName
    file = "logos/$destName"
    background = "transparent"
    source = "manual-import"
    sourceUrl = ""
    license = "review-required"
    usage = "Added from _incoming; verify source/rights before public use."
    status = "needs-review"
  }
}

$catalog = $catalog | Sort-Object { $_.id }
$catalog | ConvertTo-Json -Depth 5 | Set-Content -Path $catalogFile -Encoding UTF8
Write-Host "Imported $($catalog.Count) logo(s)."
