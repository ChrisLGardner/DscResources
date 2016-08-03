<#
    .SYNOPSIS
       A sample template for creating DSC Resource Unit Tests mainly for larger resources
    .DESCRIPTION
       To Use:
         1. Copy to \Tests\Unit\ folder and rename <ResourceName>.tests.ps1 (e.g. MSFT_xFirewall.tests.ps1)
         2. Customize TODO sections.
         3. Delete all of the template instructional comments before pushing to git repository

    .NOTES
       Code in HEADER and FOOTER regions are standard and may be moved into DSCResource.Tools in
       Future and therefore should not be altered if possible.
#>


# TODO: Customize these parameters...
$script:dscModuleName      = '<ModuleName>' # Example xNetworking
$script:dscResourceName    = '<ResourceName>' # Example MSFT_xFirewall
# /TODO

#region HEADER

# Unit Test Template Version: 1.1.0
[String] $script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if ( (-not (Test-Path -Path (Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests'))) -or `
     (-not (Test-Path -Path (Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests\TestHelper.psm1'))) )
{
    & git @('clone','https://github.com/PowerShell/DscResource.Tests.git',(Join-Path -Path $script:moduleRoot -ChildPath '\DSCResource.Tests\'))
}

Import-Module (Join-Path -Path $script:moduleRoot -ChildPath 'DSCResource.Tests\TestHelper.psm1') -Force
$TestEnvironment = Initialize-TestEnvironment `
    -DSCModuleName $script:dscModuleName `
    -DSCResourceName $script:dscResourceName `
    -TestType Unit 

#endregion HEADER



# Begin Testing
try
{

    Initialize-PesterTests

    #region Pester Test Initialization

    # TODO: Optionally create any variables here for use by your tests
    # See https://github.com/PowerShell/xNetworking/blob/dev/Tests/Unit/MSFT_xDhcpClient.Tests.ps1

    #endregion Pester Test Initialization

    # TODO: Common DSC Resource describe block structure
    # The following two Describe blocks are included as a common test pattern.
    # If a different test pattern would be more suitable, then test describe blocks
    # may be completely replaced. The goal of this pattern should be to describe 
    # the potential states a system could be in so that the get/test/set cmdlets
    # can be tested in those states. Any mocks that relate to that specific state
    # can be included in the relevant describe block. For a more detailed description
    # of this approach please review https://github.com/PowerShell/DscResources/issues/143 

    # Add as many of these example 'states' as required to simulate the scenarions that
    # the DSC resource is designed to work with, below a simple "is in desired state" and
    # "is not in desired state" are used, but there may be more complex combinations of 
    # factors, depending on how complex your resource is.

    #region Example state 1
    Describe "$($script:dscResourceName)" {
        Context 'When the system is not in the desired state' {
            BeforeAll {
                #TODO: Mock cmdlets here that represent the system not being in the desired state
            }

            #TODO: Create a set of parameters to test your get/test/set methods in this state
            $testParameters = @{
                Property1 = 'value'
                Property2 = 'value'
            }

            #TODO: Update the assertions below to align with the expected results of this state
            It 'Get method returns something' {
                Get-TargetResource @testParameters | Should Be 'something'
            }

            It 'Test method returns false' {
                Test-TargetResource @testParameters | Should be $false
            }

            It 'Set method calls Demo-CmdletName' {
                Set-TargetResource @testParameters

                #TODO: Assert that the appropriate cmdlets were called
                Assert-MockCalled Demo-CmdletName 
            }
        }
        #endregion Example state 1

        #region Example state 2
        Context 'When the system is in the desired state' {
            #TODO: Mock cmdlets here that represent the system being in the desired state

            #TODO: Create a set of parameters to test your get/test/set methods in this state
            $testParameters = @{
                Property1 = 'value'
                Property2 = 'value'
            }

            #TODO: Update the assertions below to align with the expected results of this state
            It 'The Get method should return something' {
                Get-TargetResource @testParameters | Should Be 'something'
            }

            It 'The Test method Should return true' {
                Test-TargetResource @testParameters | Should be $true
            }
        }
        #endregion Example state 2
    }

    #region Non-Exported Function Unit Tests

    # TODO: Pester Tests for any non-exported Helper Cmdlets
    # If the resource does not contain any non-exported helper cmdlets then
    # this block may be safely deleted.
    InModuleScope $script:dscResourceName {
        # The InModuleScope command allows you to perform white-box unit testing
        # on the internal (non-exported) code of a Script Module.

    }
    #endregion Non-Exported Function Unit Tests
}
finally
{
    #region FOOTER

    Complete-PesterTests

    #endregion

    # TODO: Other Optional Cleanup Code Goes Here...
}

function Initialize-PesterTests {
    
    # TODO: Optional Init Code Goes Here...
    
}

function Complete-PesterTests {

    Restore-TestEnvironment -TestEnvironment $TestEnvironment
    # TODO: Other Optional Cleanup Code Goes Here...
    
}
