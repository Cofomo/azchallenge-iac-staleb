Describe "verify-Configuration-Function" {

    It "Verify the Location" {
        $functionInfo = Get-AzWebApp -ResourceGroupName azchallenge-staleb-accept-rg -Name calicot-function-app-accept
        $functionInfo.Location | Should -Be 'Canada Central' 
    }

}