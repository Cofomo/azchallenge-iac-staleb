Describe "Verify resource creation" {

    BeforeAll {
        $resourceGroup = "azchallenge-staleb-accept-rg"
        $webAppExpected = [PSCustomObject]@{
            Name            = 'calicot-app-service-accept'
            ServicePlanName = 'calicot-service-plan-accept'
            Tier            = 'D1'
            OS              = 'Windows'
            Location        = 'Canada Central'
        }
        $functionExpected = [PSCustomObject]@{
            Name            = 'calicot-function-app-accept'
            ServicePlanName = 'calicot-azure-functions-app-service-accept'
            ConsumptionTier = 'Y1'
            Location        = 'Canada Central'
        }
        $storageAccountExpected = [PSCustomObject]@{
            Name        = 'calicotstorageaccountacc'
            AccountTier = 'Standard'
            AccessTier  = 'Hot'
            Location    = 'canadacentral'
        }
        $serviceBusExpected = [PSCustomObject]@{
            Name                = 'calicot-servicebus-accept'
            ServicebusNamespace = 'calicot-servicebus-namespace-accept'
            Tier                = 'Basic'
            Location            = 'Canada Central'
        }
        $sqlDatabaseExpected = [PSCustomObject]@{
            Name          = 'calicot-sql-database-accept'
            SqlServerName = 'calicot-sql-server-accept'
            Edition       = 'Basic'
            Location      = 'canadacentral'
        }
    }

    It "Verify the web app configuration" {
        $servicePlanInfo = Get-AzAppServicePlan -ResourceGroupName $resourceGroup -Name $webAppExpected.ServicePlanName
        $webAppInfo = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $webAppExpected.Name

        $webAppInfo.Location | Should -Be $webAppExpected.Location
        $servicePlanInfo.Sku.Name | Should -Be $webAppExpected.Tier
        $servicePlanInfo.Kind | Should -Be $webAppExpected.OS
    }

    It "Verify the function configuration" {
        $servicePlanFunctionsInfo = Get-AzAppServicePlan -ResourceGroupName $resourceGroup -Name $functionExpected.ServicePlanName
        $functionInfo = Get-AzWebApp -ResourceGroupName $resourceGroup -Name $functionExpected.Name

        $functionInfo.Location | Should -Be $functionExpected.Location
        $servicePlanFunctionsInfo.Sku.Name | Should -Be $functionExpected.ConsumptionTier
    }

    It "Verify the storage account" {
        $storageAccountInfo = Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountExpected.Name
    
        $storageAccountInfo.PrimaryLocation | Should -Be $storageAccountExpected.Location
        $storageAccountInfo.Sku.Tier | Should -Be $storageAccountExpected.AccountTier
        $storageAccountInfo.AccessTier | Should -Be $storageAccountExpected.AccessTier
    }

    It "Verify the service bus" {
        $serviceBusNamespaceInfo = Get-AzServiceBusNamespace -ResourceGroup $resourceGroup -NamespaceName $serviceBusExpected.ServicebusNamespace
        $serviceBusInfo = Get-AzServiceBusQueue -ResourceGroup $resourceGroup -NamespaceName $serviceBusExpected.ServicebusNamespace

        $serviceBusNamespaceInfo.Location | Should -Be $serviceBusExpected.Location
        $serviceBusNamespaceInfo.Sku.Name | Should -Be $serviceBusExpected.Tier
        $serviceBusInfo.Name | Should -Be $serviceBusExpected.Name
    }

    It "Verify the sql database" {
        $sqlServerInfo = Get-AzSqlServer -ResourceGroup $resourceGroup -ServerName $sqlDatabaseExpected.SqlServerName
        $sqlDatabaseInfo = Get-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $sqlDatabaseExpected.SqlServerName -Name $sqlDatabaseExpected.Name

        $sqlServerInfo.Location | Should -Be $sqlDatabaseExpected.Location
        $sqlDatabaseInfo.Edition | Should -Be $sqlDatabaseExpected.Edition
    }
}