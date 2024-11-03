@description('The name of the resource group')
param resourceGroupName string

@description('The name of the web app')
param webAppName string

@description('The location for the resources')
param location 'eastus'

@description('The SKU of the App Service Plan')
param sku string = 'F1'

@resourceGroup('Arif.Yilmaz_rg_8932')
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${webAppName}-plan'
  location: location
  sku: {
    name: sku
    tier: 'Free'
    capacity: 1
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output webAppUrl string = 'https://${webApp.name}.azurewebsites.net'
