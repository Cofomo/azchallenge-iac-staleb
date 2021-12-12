Describe "verify-Configuration-Function" {

    It "Verify the Location" {
        $functionInfo = Get-AzWebApp -ResourceGroupName azchallenge-staleb-dev-rg -Name calicot-function-app-dev
        $functionInfo.Location | Should -Be 'Canada Central' 
    }

}