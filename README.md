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
<!--| Local Fonts                | `DefaultLocalFontsSetting`      | `2`    | Ask on use         |-->
| Sensors                    | `DefaultSensorsSetting`         | `2`    | Ask on use         |
<!--| Serial Port Access         | `DefaultSerialGuardSetting`     | `2`    | Ask on use         |-->

---

##  Extensions

| Setting                        | Registry Key                         | Value | Description                                  |
|--------------------------------|--------------------------------------|--------|----------------------------------------------|
| Extension Manifest V2 Support | `ExtensionManifestV2Availability`    | `2`    | Allow legacy Manifest V2 extensions          |

---

##  Notes

- All `dword:00000000` = Disabled
- All `dword:00000001` = Enabled
- All `dword:00000002` = Prompt (Ask) for permission
- Empty strings like `""` indicate no reporting endpoint configured

This configuration is intended to maximize user privacy and minimize online tracking or feature creep in Brave browser.
