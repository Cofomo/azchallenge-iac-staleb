Describe "verify-Configuration-Function" {

    It "Verify the Location" {
        $functionInfo = Get-AzWebApp -ResourceGroupName azchallenge-staleb-prod-rg -Name calicot-function-app-prod
        $functionInfo.Location | Should -Be 'Canada Central' 
    }

}