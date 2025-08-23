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

## Usage on macOS (User Preferences)

This branch of the script writes Brave’s policy keys into the **user preferences domain**  
(`~/Library/Preferences/com.brave.Browser*.plist`) instead of the managed system domain.

### Key points
- Settings **persist across reboots** because they live in your user prefs.
- They appear in `brave://policy` as **OK (recommended)**, not **Policy Enforced**.
- No root or sudo required — everything runs in the user context.
- Works with **Stable**, **Beta**, and **Nightly** via the `--channel` flag.

### Running

```bash
chmod +x clean_brave.sh

# Stable (default)
./clean_brave.sh

# Beta
./clean_brave.sh --channel=beta

# Nightly
./clean_brave.sh --channel=nightly


##  Notes
- Some Chromium policy keys aren’t honored by Brave unless the browser is
  enrolled in **Brave Browser Cloud Management** (MDM/enterprise environment).
- Specifically:
  - `CloudReportingEnabled` → Ignored with the message  
    *"Ignored because the machine is not enrolled with Brave Browser Cloud Management."*
  - `MetricsReportingEnabled` → Blocked with the message  
    *"This policy is blocked, its value will be ignored."*
- These keys have been removed from the script to avoid noisy errors in
  `brave://policy`.
  
This configuration is intended to maximize user privacy and minimize online tracking or feature creep in Brave browser.

---

## Credits

Thanks to **Mojszli** for the inspiration to create a macOS version and for the base README template.
