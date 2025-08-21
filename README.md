# Please close Brave While Running the file!

##  Disabled Features

The following Brave features are explicitly disabled:

| Feature                         | Policy                            | Status    |
|---------------------------------|------------------------------------|-----------|
| Brave Rewards                   | `BraveRewardsDisabled`            | Disabled  |
| Brave Wallet                    | `BraveWalletDisabled`             | Disabled  |
| Brave VPN                       | `BraveVPNDisabled`                | Disabled  |
| Brave AI Chat                   | `BraveAIChatEnabled`              | Disabled  |
| Password Manager                | `PasswordManagerEnabled`          | Disabled  |
| Password Sharing                | `PasswordSharingEnabled`          | Disabled  |
| Password Leak Detection         | `PasswordLeakDetectionEnabled`    | Disabled  |
| Quick Answers                   | `QuickAnswersEnabled`             | Disabled  |
| Autofill Credit Cards           | `AutofillCreditCardEnabled`       | Disabled  |

---

##  Telemetry & Reporting

All telemetry, reporting, and device data sharing settings are disabled:

| Functionality                      | Registry Key                           | Status    |
|------------------------------------|----------------------------------------|-----------|
| Cloud Reporting                    | `CloudReportingEnabled`               | Disabled  |
| Safe Browsing Extended Reporting   | `SafeBrowsingExtendedReportingEnabled`| Disabled  |
| Safe Browsing Surveys              | `SafeBrowsingSurveysEnabled`          | Disabled  |
| Deep Scanning                      | `SafeBrowsingDeepScanningEnabled`     | Disabled  |
| Metrics & Heartbeats               | `DeviceMetricsReportingEnabled`, `HeartbeatEnabled`, `DeviceActivityHeartbeatEnabled`, `LogUploadEnabled` | Disabled |
| Device Activity & Inventory        | `ReportAppInventory`, `ReportDeviceActivityTimes`, `ReportDeviceAppInfo`, `ReportDeviceSystemInfo`, `ReportDeviceUsers` | Disabled |
| Website Telemetry                  | `ReportWebsiteTelemetry`              | Disabled  |
| General Metrics Reporting          | `MetricsReportingEnabled`             | Disabled  |

---

##  Default Permissions (Prompt or Block)

These default settings control how Brave handles specific browser API permissions:

| API / Setting              | Registry Key                     | Value | Description        |
|----------------------------|----------------------------------|--------|--------------------|
| Geolocation                | `DefaultGeolocationSetting`     | `2`    | Ask on use         |
| Notifications              | `DefaultNotificationsSetting`   | `2`    | Ask on use         |
| Sensors                    | `DefaultSensorsSetting`         | `2`    | Ask on use         |

---

##  Extensions

| Setting                        | Registry Key                         | Value | Description                                  |
|--------------------------------|--------------------------------------|--------|----------------------------------------------|
| Extension Manifest V2 Support | `ExtensionManifestV2Availability`    | `2`    | Allow legacy Manifest V2 extensions          |

---

## Usage on macOS

A helper script [`cleanbrave.sh`](./cleanbrave.sh) is included to apply these policies automatically
to Brave’s managed preferences.

The script:

- Ensures `/Library/Managed Preferences/` exists with correct `root:wheel` ownership and `755` permissions.
- Creates/updates `/Library/Managed Preferences/com.brave.Browser.plist`.
- Sets all the policies listed above (disabled features, telemetry off, default prompts).
- Will update keys if they already exist (idempotent, no duplicates).
- Prints out which keys were added/updated.

### Running

> ⚠️ Please close Brave before running the script.

chmod +x cleanbrave.sh
sudo ./cleanbrave.sh

##  Notes
Will upate this later too be mac specfi about about plist settings

This configuration is intended to maximize user privacy and minimize online tracking or feature creep in Brave browser.

---

## Credits

Thanks to **Mojszli** for the inspiration to create a macOS version and for the base README template.
