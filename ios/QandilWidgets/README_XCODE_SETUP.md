# iOS WidgetKit Extension & App Group Setup Guide (`com.mmazin.qandil`)

The complete SwiftUI `WidgetBundle` (`QandilNextPrayerWidget`, `QandilFivePrayersWidget`, `QandilTasbihWidget`, `QandilWirdWidget`) and entitlement files are located in `ios/QandilWidgets/` and `ios/Runner/Runner.entitlements`.

## Exact Xcode Steps & Signing Notes

1. **Open the iOS Workspace in Xcode:**
   ```bash
   open ios/Runner.xcworkspace
   ```
2. **Add the Widget Extension Target:**
   - In Xcode, select **File → New → Target…** → **iOS** → **Widget Extension** → **Next**.
   - **Product Name:** `QandilWidgets`
   - **Uncheck** *Include Live Activity* and *Include Configuration App Intent*.
   - Verify the Bundle Identifier is `com.mmazin.qandil.QandilWidgets` and click **Finish** (click **Activate** if prompted).
   - Replace the Xcode-generated template Swift file in the `QandilWidgets` target with `ios/QandilWidgets/QandilWidgets.swift` (already written in this folder).
3. **Configure the Shared App Group (`group.com.mmazin.qandil`) on Both Targets:**
   - Select the **Runner** project in the left navigator:
     - Select the **Runner** target → **Signing & Capabilities** tab → click **+ Capability** → **App Groups**.
     - Enable/check **`group.com.mmazin.qandil`** (matches `ios/Runner/Runner.entitlements`).
     - Select the **QandilWidgets** target → **Signing & Capabilities** tab → click **+ Capability** → **App Groups**.
     - Enable/check **`group.com.mmazin.qandil`** (matches `ios/QandilWidgets/QandilWidgets.entitlements`).
4. **Signing & Deployment Target Notes:**
   - Both **Runner** and **QandilWidgets** must use the **same Apple Developer Team** so they can read/write the shared `group.com.mmazin.qandil` container (`UserDefaults(suiteName: "group.com.mmazin.qandil")`).
   - Set **QandilWidgets → General → Minimum Deployments** to **iOS 16.0** (or match `Runner`'s iOS deployment target).
   - In App Store Connect / Apple Developer Portal (**Certificates, Identifiers & Profiles → Identifiers**), ensure both `com.mmazin.qandil` and `com.mmazin.qandil.QandilWidgets` have the **App Groups** capability enabled and assigned to `group.com.mmazin.qandil`.
