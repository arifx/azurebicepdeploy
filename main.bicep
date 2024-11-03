@description('The name of the App Service Plan')
param appServicePlanName string = 'ArifASP'

@description('The name of the Web App')
param webAppName string = 'ArifFlaskWebApp'

@description('The location where the resources will be deployed')
param location string = resourceGroup().location

@description('The SKU and Size of the App Service Plan')
param skuName string = 'S1'
param skuTier string = '1'

@description('The Python version for the Web App')
param pythonVersion string = '3.9'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    capacity: 1
  }
  kind: 'app'
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.9'
    }
  }
}

output webAppUrl string = 'arifflaskapp'
