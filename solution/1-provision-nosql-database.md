Azure CLI:

az group create -g rg-contoso-video -l ukwest
az cosmosdb create --name cdb-contoso-video --resource-group rg-contoso-video --subscription $InternalSub --locations regionName=ukwest failoverPriority=0 isZoneRedundant=False --backup-redundancy Local

az deployment create --resource-group rg-contoso-video --template-file 1-provision-nosql-database.template.json --parameters 1-provision-nosql-database.parameters.json