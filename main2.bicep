@description('The name of the App Service Plan')
param appServicePlanName string = 'ArifASP'

@description('The name of the Web App')
param webAppName string = 'ArifFlaskWebApp2'

@description('The location where the resources will be deployed')
param location string = resourceGroup().location

@description('The SKU and Size of the App Service Plan')
param skuName string = 'S1'

@description('The capacity for the App Service Plan')
param skuCapacity int = 1

@description('The Python version for the Web App')
param pythonVersion string = '3.9'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: 'Standard'  // Added tier to specify Standard tier explicitly
    capacity: skuCapacity
  }
  kind: 'app'
  properties: {
    reserved: true  // Specifies Linux hosting
  }
}

resource webApp 'Microsoft.Web/sites@2023-12-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|${pythonVersion}'  // Uses pythonVersion parameter
    }
    httpsOnly: true  // Optional: forces HTTPS
  }
}

output webAppUrl string = 'ArifHostName'
