# iOS System Sound

<div align="center">
   <img src="https://raw.githubusercontent.com/runoob-coder/ios_system_sound/master/ios-system-sound.png" width="200" style="width: 200px;" alt="iOS System Sound">
</div>

[![Pub Version](https://img.shields.io/pub/v/ios_system_sound.svg)][pub]
[![API Reference](https://img.shields.io/badge/API-Reference-0175C2.svg)](https://pub.dev/documentation/ios_system_sound/latest/)
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/runoob-coder/ios_system_sound)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/runoob-coder/ios_system_sound.svg?style=social)][GitHub]
[![CI](https://img.shields.io/github/actions/workflow/status/runoob-coder/ios_system_sound/analyze.yml?label=CI)](https://github.com/runoob-coder/ios_system_sound/actions/workflows/analyze.yml)

Playing UI sound effects or invoking vibration using System Sound Services on iOS.

English | [简体中文](https://github.com/runoob-coder/ios_system_sound/blob/master/README_CN.md)

## ✨ Features

- 🎛️ Plays **every predefined iOS system sound** (`SystemSoundID`): mail, SMS,
  alerts, key presses, camera, recording, DTMF, headset, ...
- 📳 Triggers **vibration** through `kSystemSoundID_Vibrate`.
- 🔢 Plays **arbitrary raw IDs** that are not part of the enum yet.
- 🗂️ Ships **metadata** for every sound: the system category it belongs to, so
  grouped UI comes for free.
- 🤝 **Safe cross-platform**: all calls are no-ops outside of iOS.

## 📦 Installation

Add the latest version with:

```bash
flutter pub add ios_system_sound
```

Then import it:

```dart
import 'package:ios_system_sound/ios_system_sound.dart';
```

Requirements: **iOS 13.0+**.

## 🚀 Usage

### 🔊 Play a system sound

```dart
final sound = IosSystemSound();

// Camera shutter / 相机快门声
await sound.play(SystemSoundID.photoShutter);

// Message sent
await sound.play(SystemSoundID.sentMessage);

// Unlock
await sound.play(SystemSoundID.unlock);
```

The returned `Future` resolves as soon as playback has been handed over to the
system — it does **not** wait for the sound to finish. System Sound Services
ignores IDs that do not exist on the current device, so nothing else happens in
that case.

### ⏭️ Play sounds one after another

Pass `waitForCompletion: true` and the `Future` resolves only when the system
reports the playback as finished, so a list of sounds can be played in sequence
without guessing how long each one lasts:

```dart
for (final id in SystemSoundID.byCategory[SystemSoundCategory.alert]!) {
  await sound.play(id, waitForCompletion: true);
}
```

`vibrate()` and `playRawId()` accept the same flag. On platforms other than iOS
the calls stay no-ops and resolve immediately.

### 📳 Vibrate

```dart
await sound.vibrate();
```

### 🔢 Play a raw sound ID

Useful for IDs that are missing from the enum, or for sounds created with
`AudioServicesCreateSystemSoundID` on the native side.

```dart
await sound.playRawId(1108); // same as SystemSoundID.photoShutter
```

### 🔍 Look up a sound by its value

```dart
SystemSoundID.fromValue(1004);      // SystemSoundID.sentMessage
SystemSoundID.tryFromValue(42);     // null
SystemSoundID.photoShutter.value;   // 1108
SystemSoundID.photoShutter.category; // SystemSoundCategory.camera
```

### 🧩 Build grouped UI

```dart
for (final entry in SystemSoundID.byCategory.entries) {
  final category = entry.key; // SystemSoundCategory.headset
  final sounds = entry.value;
}
```

## 🗂️ Sound categories

| Category | Count | Examples |
| --- | ---: | --- |
| `SystemSoundCategory.mail` | 4 | `newMail`, `mailSent`, `voiceMailReceived` |
| `SystemSoundCategory.sms` | 11 | `receivedMessage`, `sentMessage`, `smsReceived1` |
| `SystemSoundCategory.alert` | 18 | `alarm`, `bloom`, `noir` |
| `SystemSoundCategory.keyPress` | 5 | `tink`, `tock`, `tinkKeyPressed` |
| `SystemSoundCategory.power` | 2 | `lowPower`, `connectedToPower` |
| `SystemSoundCategory.simToolkit` | 5 | `simToolkitSMS` |
| `SystemSoundCategory.network` | 1 | `ussd` |
| `SystemSoundCategory.callTone` | 6 | `ctBusy`, `ctError`, `ctCallWaiting` |
| `SystemSoundCategory.device` | 5 | `lock`, `unlock`, `shake` |
| `SystemSoundCategory.camera` | 1 | `photoShutter` |
| `SystemSoundCategory.recording` | 4 | `beginRecord`, `endVideoRecord` |
| `SystemSoundCategory.voiceChat` | 9 | `jblBegin`, `vcEnded`, `vcRinging` |
| `SystemSoundCategory.touchTone` | 12 | `dtmf0` ... `dtmfPound` |
| `SystemSoundCategory.headset` | 6 | `longLowShortHigh` |
| `SystemSoundCategory.preview` | 33 | `voicemail2`, `updateSelection` |
| `SystemSoundCategory.vibration` | 3 | `vibrate` |
| `SystemSoundCategory.unknown` | 1 | `webcamStart` |

126 sounds in total (`SystemSoundID.values.length`).

## 📱 Example app

The bundled [example](example) app browses every sound grouped by category, with
a search field that matches sound names, category names and numeric IDs, plus
a button for each category that plays every sample in sequence.

```bash
cd example && flutter run
```

> [!NOTE]
> The **iOS Simulator does not play system sounds** — run the example on a real
> device to hear them.

## 🌍 Platform behaviour

System Sound Services only exists on iOS. Calls made from any other platform are
ignored (a message is written with `debugPrint` in debug builds), so you can
share a single code path across a cross-platform app without extra branching.

| Platform | Behaviour |
| --- | --- |
| iOS | Plays / vibrates |
| Everything else | No-op |

## 📝 Notes

> [!NOTE]
> The set of supported sound IDs may vary slightly across iOS versions and
> devices. This library is being continuously supplemented.

> [!NOTE]
> Sounds played via System Sound Services are not subject to Audio Session
> configuration, so they cannot be aligned with other audio behaviour in your
> app. This is the main reason to avoid using System Sound Services for anything
> other than its intended purpose.

## 🔗 References

- [Apple - Using Audio (System Sound Services)](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MultimediaPG/UsingAudio/UsingAudio.html)
- [AudioServicesPlaySystemSound(_:)](https://developer.apple.com/documentation/audiotoolbox/audioservicesplaysystemsound(_:))
- [iOSSystemSoundsLibrary](https://github.com/TUNER88/iOSSystemSoundsLibrary)


## 💛 Support

If [`ios_system_sound`][pub] helps you build better apps, please consider
supporting it.  
It only takes a few seconds and helps other Flutter developers discover the
library.

- ⭐ [Star on GitHub][GitHub]
- 👍 [Like on pub.dev][pub]

## [☕️ Buy Me a Coffee](https://www.noob-coder.com/buy-me-a-coffee)

|                                                                                   Buy Me a Coffee                                                                                   |                                                                                    Donate with PayPal                                                                                     |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| <a href="https://ko-fi.com/noob_coder" target="_blank"><img src="https://github.com/runoob-coder/runoob-coder/raw/main/public/kofi6.webp" alt="Buy Me a Coffee at ko-fi.com" /></a> | <a href="https://paypal.me/runoobcoder" target="_blank"><img src="https://github.com/runoob-coder/runoob-coder/raw/main/public/paypal-donate-button.avif" alt="Donate with PayPal" /></a> |

[pub]: https://pub.dev/packages/ios_system_sound

[GitHub]: https://github.com/runoob-coder/ios_system_sound

