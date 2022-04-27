$PathProd = "C:\_home\github-temp\xml.config"
$PathOriginal = "C:\_home\github-temp\xml.config.001.original"
$NewDomain = "*.abc.fake"

if (Test-Path -Path $PathProd) {
   if (-not(Test-Path -Path $PathOriginal)){
      Copy-Item $PathProd $PathOriginal
      Write-Host "Created backup"
   } else {
      Write-Host "backup already exists"
   }
   [xml]$xml = Get-Content -Path $PathProd
   $webDomains = $xml.SelectSingleNode("//configuration/appSettings/add[@key = 'webDomains']")
   if ($webDomains.value.Contains($NewDomain)){
      Write-Host "Value IS present, not changes made."
   } else {
      Write-Host "Value NOT present in: " $webDomains.value
      $newValue = $webDomains.value + ', ' + $NewDomain
      Write-Host "New string value: " $newValue
      $webDomains.SetAttribute('value', $newValue)
      $xml.Save($PathProd)
   }
}
