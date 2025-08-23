#!/usr/bin/env bash
set -euo pipefail

# ----------------------------
# Channel flag (default stable)
# ----------------------------
BUNDLE_ID="com.brave.Browser"  # stable
while [[ $# -gt 0 ]]; do
  case "$1" in
    --channel=stable)  BUNDLE_ID="com.brave.Browser";;
    --channel=beta)    BUNDLE_ID="com.brave.Browser.beta";;
    --channel=nightly) BUNDLE_ID="com.brave.Browser.nightly";;
    --channel=*) echo "Unknown channel: ${1#--channel=}"; exit 1;;
    -h|--help)
      echo "Usage: $0 [--channel=stable|beta|nightly]"; exit 0;;
    *) break;;
  esac
  shift
done

# ----------------------------
# Paths / tools
# ----------------------------
PREFS_DIR="${HOME}/Library/Preferences"
PLIST="${PREFS_DIR}/${BUNDLE_ID}.plist"
PB="${PB:-/usr/libexec/PlistBuddy}"
[[ -x "$PB" ]] || { echo "PlistBuddy not found at: $PB" >&2; exit 1; }

# ----------------------------
# Helpers
# ----------------------------
ensure() {
  echo "Using user prefs dir: $PREFS_DIR"
  echo "Target plist:         $PLIST"

  [[ -d "$PREFS_DIR" ]] || mkdir -p "$PREFS_DIR"

  # Ensure a valid XML plist exists (avoid zero-length parse errors)
  if [[ ! -f "$PLIST" || ! -s "$PLIST" ]]; then
    /usr/bin/plutil -create xml1 "$PLIST" || { echo "plutil create failed"; exit 1; }
  fi

  # Quick peek
  /usr/bin/plutil -lint "$PLIST" >/dev/null || true
}

set_key() { # set_key <key> <type> <value>
  local k="$1" t="$2" v="$3"
  if "$PB" -c "Print :$k" "$PLIST" &>/dev/null; then
    "$PB" -c "Set :$k $v" "$PLIST"
    echo "Updated $k → $v"
  else
    "$PB" -c "Add :$k $t $v" "$PLIST"
    echo "Added   $k → $v"
  fi
}

# ----------------------------
# Main
# ----------------------------
main() {
  ensure

  # ===== Brave features (disabled) =====
  set_key BraveRewardsDisabled         bool true
  set_key BraveWalletDisabled          bool true
  set_key BraveVPNDisabled             bool true
  set_key BraveAIChatEnabled           bool false
  set_key PasswordManagerEnabled       bool false
  set_key PasswordSharingEnabled       bool false
  set_key PasswordLeakDetectionEnabled bool false
  set_key QuickAnswersEnabled          bool false
  set_key AutofillCreditCardEnabled    bool false

  # ===== Telemetry & reporting (disabled) =====
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

  # ===== Default permissions (Ask on use = 2) =====
  set_key DefaultGeolocationSetting   integer 2
  set_key DefaultNotificationsSetting integer 2
  set_key DefaultSensorsSetting       integer 2
  # (if you later want others, add here)

  # ===== Extensions =====
  set_key ExtensionManifestV2Availability integer 2

  # Refresh prefs cache so Brave sees changes immediately
  killall cfprefsd 2>/dev/null || true

  echo
  echo "✅ User Brave preferences written to: $PLIST"
  echo "   Open brave://policy — these show as \"OK (recommended)\" (not enforced)."
}

main "$@"
