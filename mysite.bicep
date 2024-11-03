param appname 'mysitetest'
param envname 'bash'
param loc string ='westus'
targetScope = 'subscription'

var rgname ='rg-${appname}=${envname}' 

resource rg 'Microsoft.Resources/resourceGroups@2024-07-01'={
  name : rgname
  location : loc
}


