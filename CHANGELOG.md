## 0.1.0

### ✨ Features

- `IosSystemSound().vibrate()` — haptic feedback via `kSystemSoundID_Vibrate` (4095).
- `IosSystemSound().playRawId()` for IDs missing from the enum; values outside `0...0xFFFFFFFF` throw an `ArgumentError`.
- `play()`, `playRawId()` and `vibrate()` accept `waitForCompletion: true`, so sounds can be played one after another.
- Completed `SystemSoundID`: 126 sounds with `value` and `SystemSoundCategory`, plus `fromValue()` / `tryFromValue()` and `byCategory`.
- Supplemented IDs `1107`, `1307`–`1315`, `1320`–`1336`, `1350`, `1351` and `4095`.

### 🐛 Fixes

- `PlatformException`s are rethrown instead of being printed.
- Non-iOS platforms no-op instead of raising `MissingPluginException`.

### 📱 iOS

- Added the `vibrate` method, switched to `AudioToolbox`, and hardened `soundId` parsing (`UInt32` round-trip check).

## 0.0.2

- ⬆️ Updated SDK constraints: Dart ^3.10.0, Flutter >=3.38.0

## 0.0.1

- 🎉 Initial release: play iOS system UI sound effects via System Sound Services.
- 🔢 `SystemSoundID` enum covering the predefined sounds (1000~1306).
