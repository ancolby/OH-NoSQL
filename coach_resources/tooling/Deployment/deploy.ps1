# Enter the first Resource Group name (i.e. openhack1)
$resourceGroup1Name = "openhack1"
# Enter the second Resource Group name (i.e. openhack2)
$resourceGroup2Name = "openhack2"
# Enter the location for the first resource group (i.e. westus2)
$location1 = "westus2"
# Enter the location for the second resource group (i.e. eastus)
$location2 = "eastus"
# Enter the SQL Server username (i.e. openhackadmin)
$sqlAdministratorLogin = "openhackadmin"
# Enter the SQL Server password (i.e. Password123)
$sqlAdministratorLoginPassword = "Password123"

$suffix = -join ((48..57) + (97..122) | Get-Random -Count 13 | % {[char]$_})
$suffix2 = -join ((48..57) + (97..122) | Get-Random -Count 13 | % {[char]$_})
$databaseName = "Movies"
$sqlserverName = "openhacksql-$suffix"

New-AzResourceGroup -Name $resourceGroup1Name -Location $location1
New-AzResourceGroup -Name $resourceGroup2Name -Location $location2

$templateUri = "https://raw.githubusercontent.com/microsoft/OpenHack/byos/byos/app-modernization-no-sql/deploy/azuredeploy.json"

$outputs = New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroup1Name `
    -TemplateUri $templateUri `
    -secondResourceGroup $resourcegroup2Name `
    -secondLocation $location2 `
    -sqlserverName $sqlserverName `
    -sqlAdministratorLogin $sqlAdministratorLogin `
    -sqlAdministratorLoginPassword $(ConvertTo-SecureString -String $sqlAdministratorLoginPassword -AsPlainText -Force) `
    -suffix $suffix `
    -suffix2 $suffix2

#$sqlSvrFqdn = $outputs.Outputs["sqlSvrFqdn"].value
#$sqlserverName = $outputs.Outputs["sqlserverName"].value

$importRequest = New-AzSqlDatabaseImport -ResourceGroupName $resourceGroup1Name `
    -ServerName $sqlserverName -DatabaseName $databaseName `
    -DatabaseMaxSizeBytes "2147483648" `
    -StorageKeyType "SharedAccessKey" `
    -StorageKey "?sp=r&st=2021-02-17T20:02:21Z&se=2029-02-18T04:02:21Z&spr=https&sv=2020-02-10&sr=c&sig=lOB9HD8lK%2FU1X%2B9T9TacfE5T1a40R4e6q0f59RhjZU4%3D" `
    -StorageUri "https://openhackguides.blob.core.windows.net/no-sql-artifacts/movies.bacpac" `
    -Edition "Basic" -ServiceObjectiveName "Basic" `
    -AdministratorLogin $sqlAdministratorLogin `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $sqlAdministratorLoginPassword -AsPlainText -Force)

$importStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink

[Console]::Write("Importing database")
while ($importStatus.Status -eq "InProgress") {
    $importStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink
    [Console]::Write(".")
    Start-Sleep -s 10
}

[Console]::WriteLine("")
$importStatus
