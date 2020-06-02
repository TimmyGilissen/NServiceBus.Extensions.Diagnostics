$scriptName = $MyInvocation.MyCommand.Name
$artifacts = "./artifacts"

if ($Env:MYGET_JBOGARD_CI_API_KEY -eq $null) {
    Write-Host "${scriptName}: MYGET_JBOGARD_CI_API_KEY is empty or not set. Skipped pushing package(s)."
} else {
    Get-ChildItem $artifacts -Filter "*.nupkg" | ForEach-Object {
        Write-Host "$($scriptName): Pushing $($_.Name)"
        dotnet nuget push $_ --source https://www.myget.org/F/jbogard-ci/api/v2/package --api-key $Env:MYGET_JBOGARD_CI_API_KEY
        if ($lastexitcode -ne 0) {
            throw ("Exec: " + $errorMessage)
        }
    }
}
