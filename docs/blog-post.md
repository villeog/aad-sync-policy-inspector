# Automating Azure AD Sync Cycles and Policy Visibility with PowerShell

In your work as a devops engineer, you may need to verify Azure AD sync status and Conditional Access policy enforcement. Manual checks are slow and error-prone — this PowerShell script that automates the sync cycle, detects the authentication method, and optionally pulls Conditional Access policies via Microsoft Graph can help.

## 🔍 Why This Matters

- Sync issues can block user provisioning or delay policy enforcement.
- Knowing your sync type (PasswordHashSync vs Federation) helps troubleshoot SSO and MFA behavior.
- Conditional Access policies are often overlooked until they break something.

## ⚙️ What the Script Does

- Starts a sync cycle (Initial or Delta)
- Detects sync type from Azure AD Connect config
- Displays scheduler status
- Optionally pulls Conditional Access policies via Graph API

## 🧪 Real-World Use Case

While troubleshooting a delayed MFA rollout, I used this script to confirm:
- Sync was running Delta only
- Sync type was PasswordHashSync
- Conditional Access policy was enabled but scoped to a test group

This helped isolate the issue and accelerate rollout.

## 🛠 Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/villog/aad-sync-policy-inspector.git
