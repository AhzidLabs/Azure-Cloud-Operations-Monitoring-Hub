// ================================
// Azure Cloud Ops Monitoring Hub
// Phase 2 - Task 1 (Step 1)
// Core Resources: RG + Storage
// ================================

@description('Deployment location')
param location string = resourceGroup().location

// --------------------------------
// Resource Group (deployed context)
// --------------------------------
// You normally create this once in Azure Portal or CLI before running the template.
// It’s referenced automatically, so no resource block is needed here.

// --------------------------------
// Storage Account
// --------------------------------
resource stg 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stopsprod'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}

Phase 2 Task 1 – Added Resource Group context + Storage Account

// --------------------------------
// App Service Plan
// --------------------------------
resource plan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'asp-ops-prod'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

// --------------------------------
// App Service (Web App)
// --------------------------------
resource app 'Microsoft.Web/sites@2022-09-01' = {
  name: 'app-ops-web-prod'
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
  }
  identity: {
    type: 'SystemAssigned'
  }
}

