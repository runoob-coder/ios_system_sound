# ios_system_sound_example

Demonstrates the [`ios_system_sound`](../README.md) plugin.

The app lets you browse every predefined iOS system sound — grouped by
`SystemSoundCategory` — play each sample, trigger vibration, and play a whole
category in sequence.

## ✨ Highlights

- **Quick actions** for `vibrate()` and the camera shutter sound.
- **Grouped catalogue**: one `CupertinoListSection` per `SystemSoundCategory`.
- **Search** matching sound names, category names and numeric IDs.
- **Play all** per category, so the whole range of alert tones can be auditioned
  one after another.
- **Platform notice** when System Sound Services is unavailable.

## 🚀 Getting Started

```bash
cd example
flutter pub get
flutter run
```

> System Sound Services only exists on iOS **and the simulator does not play
> system sounds** — run the app on a real device to hear them. On every other
> platform the calls are no-ops and the list stays browsable.

## 🧪 Tests

```bash
flutter test                          # widget tests
flutter test integration_test          # integration tests (run on a device)
```

And Swift unit tests for the native implementation can be run from Xcode with
`RunnerTests` (`⌘U`).

## 📁 Project layout

```
example/
  lib/
    main.dart                            # app entry point
    src/
      sound_explorer_screen.dart         # grouped catalogue + search
      sound_list_tile.dart               # a single sound row
      unsupported_platform_banner.dart    # non-iOS notice
  test/                                  # widget tests
  integration_test/                      # device integration tests
```
