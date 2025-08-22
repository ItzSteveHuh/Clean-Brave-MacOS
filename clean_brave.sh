#!/usr/bin/env bash
set -euo pipefail

# Default bundle ID (stable)
BUNDLE_ID="com.brave.Browser"

# Parse optional --channel flag
while [[ $# -gt 0 ]]; do
  case "$1" in
    --channel=stable)  BUNDLE_ID="com.brave.Browser";;
    --channel=beta)    BUNDLE_ID="com.brave.Browser.beta";;
    --channel=nightly) BUNDLE_ID="com.brave.Browser.nightly";;
    --channel=*) echo "Unknown channel: ${1#--channel=}"; exit 1;;
    *) break;;
  esac
  shift
done

MANAGED_DIR="/Library/Managed Preferences"
PLIST="${MANAGED_DIR}/${BUNDLE_ID}.plist"


ensure() {
  # Create /Library/Managed Preferences with correct perms if missing
  if [[ ! -d "$MANAGED_DIR" ]]; then
    sudo mkdir -p "$MANAGED_DIR"
    sudo chown root:wheel "$MANAGED_DIR"
    sudo chmod 755 "$MANAGED_DIR"
  fi

  # Ensure the plist file exists
  [[ -f "$PLIST" ]] || sudo /usr/bin/touch "$PLIST"
}


set_key() { # set_key <key> <type> <value>
  local k="$1" t="$2" v="$3"
  if sudo $PB -c "Print :$k" "$PLIST" &>/dev/null; then
    sudo $PB -c "Set :$k $v" "$PLIST"
    echo "Updated $k → $v"
  else
    sudo $PB -c "Add :$k $t $v" "$PLIST"
    echo "Added $k → $v"
  fi
}


main() {
  ensure

  # === Brave features (Disabled in your README) ===
  # *_Disabled policies => set TRUE to disable the feature.
  set_key BraveRewardsDisabled           bool true
  set_key BraveWalletDisabled            bool true
  set_key BraveVPNDisabled               bool true
  # *Enabled policy in README marked "Disabled" => set FALSE.
  set_key BraveAIChatEnabled             bool false
  set_key PasswordManagerEnabled         bool false
  set_key PasswordSharingEnabled         bool false
  set_key PasswordLeakDetectionEnabled   bool false
  set_key QuickAnswersEnabled            bool false
  set_key AutofillCreditCardEnabled      bool false

  # === Telemetry & reporting (all “Disabled” in your README) ===
  set_key CloudReportingEnabled                bool false
  set_key SafeBrowsingExtendedReportingEnabled bool false
  set_key SafeBrowsingSurveysEnabled           bool false
  set_key SafeBrowsingDeepScanningEnabled      bool false
  set_key DeviceMetricsReportingEnabled        bool false
  set_key HeartbeatEnabled                     bool false
  set_key DeviceActivityHeartbeatEnabled       bool false
  set_key LogUploadEnabled                     bool false
  set_key ReportAppInventory                   bool false
  set_key ReportDeviceActivityTimes            bool false
  set_key ReportDeviceAppInfo                  bool false
  set_key ReportDeviceSystemInfo               bool false
  set_key ReportDeviceUsers                    bool false
  set_key ReportWebsiteTelemetry               bool false
  set_key MetricsReportingEnabled              bool false

  # === Defaults from README ===
  # 2 = Ask / Prompt on use
  set_key DefaultGeolocationSetting       integer 2
  set_key DefaultNotificationsSetting     integer 2
  set_key DefaultSensorsSetting           integer 2

  # === Extensions (from README) ===
  # 2 = allow Manifest V2 extensions
  set_key ExtensionManifestV2Availability integer 2

  # Make sure prefs cache reloads
  sudo killall cfprefsd 2>/dev/null || true

  echo "✅ Managed Brave policies written to: $PLIST"
  echo "→ Verify in Brave: brave://policy (should show 'Policy Enforced')"
}

main "$@"
