# aad-sync-policy-inspector
# 🔄 Azure AD Sync + Conditional Access Policy Inspector

This PowerShell script automates Azure AD Connect sync cycles, detects authentication type, and optionally retrieves Conditional Access policies via Microsoft Graph.

## 🚀 Features

- Start Initial or Delta sync cycles
- Auto-detect sync type: PasswordHashSync, Federation, PassThrough
- Display sync scheduler status
- Fetch Conditional Access policies (optional)
- Modular and reusable for automation or documentation

## 🛠 Requirements

- PowerShell 5.1+
- AzureAD or Microsoft Graph PowerShell SDK
- Graph API permissions: `Policy.Read.All`

## 📦 Usage

```powershell
.\Start-AADSyncEnhanced.ps1 -SyncPolicyType Initial -FetchPolicies
