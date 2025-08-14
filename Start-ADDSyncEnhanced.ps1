<#
.SYNOPSIS
  Initiates Azure AD Connect sync, auto-detects sync type, and retrieves Conditional Access policies via Graph API.

.DESCRIPTION
  This script starts a sync cycle, inspects Azure AD Connect configuration to determine sync type,
  and optionally queries Microsoft Graph for Conditional Access policies.

.NOTES
  Author: ville
  Last Updated: August 2025
#>

param (
    [ValidateSet("Initial", "Delta")]
    [string]$SyncPolicyType = "Delta",
    [switch]$FetchPolicies
)

# Start sync
Write-Host "🔄 Starting Azure AD Sync: $SyncPolicyType" -ForegroundColor Cyan
Start-ADSyncSyncCycle -PolicyType $SyncPolicyType

# Detect sync type from Azure AD Connect config
$aadConnectConfig = Get-ADSyncGlobalSettings
$authType = $aadConnectConfig.AuthenticationType

switch ($authType) {
    "PasswordHashSync" { $SyncType = "Password Hash Sync" }
    "Federation"       { $SyncType = "Federation (AD FS or third-party IdP)" }
    "PassThrough"      { $SyncType = "Pass-through Authentication" }
    default            { $SyncType = "Unknown or Custom Configuration" }
}

Write-Host "`n🔍 Detected Sync Type: $SyncType" -ForegroundColor Green

# Check scheduler status
$scheduler = Get-ADSyncScheduler
Write-Host "`n🕒 Sync Scheduler Status:" -ForegroundColor Yellow
$scheduler | Format-List

# Optional: Fetch Conditional Access policies via Graph API
if ($FetchPolicies) {
    Write-Host "`n📡 Fetching Conditional Access Policies from Microsoft Graph..." -ForegroundColor Magenta

    # Requires Graph permissions: Policy.Read.All
    $token = Get-MgGraphAccessToken  # Replace with your token retrieval method
    $headers = @{ Authorization = "Bearer $token" }

    $policies = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Headers $headers

    foreach ($policy in $policies.value) {
        Write-Host "🔐 Policy: $($policy.displayName)" -ForegroundColor White
        Write-Host "    State: $($policy.state)"
        Write-Host "    Conditions: $(($policy.conditions.users.includeUsers -join ', '))"
        Write-Host ""
    }
}
