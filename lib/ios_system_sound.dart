import 'enum/ios_system_sounds.dart';
import 'ios_system_sound_platform_interface.dart';

export 'enum/ios_system_sounds.dart';

/// Plays iOS UI sound effects — or triggers vibration — through
/// [System Sound Services](https://developer.apple.com/documentation/audiotoolbox/system-sound-services).
///
/// All calls are no-ops on platforms other than iOS.
///
/// ```dart
/// final sound = IosSystemSound();
///
/// await sound.play(SystemSoundID.photoShutter);
/// await sound.vibrate();
/// ```
///
/// > The sounds are not driven by `AVAudioSession`, so they are neither mixable
/// > nor routable and cannot be aligned with the rest of your app's audio.
class IosSystemSound {
  IosSystemSound();

  IosSystemSoundPlatform get _platform => .instance;

  /// Plays a predefined [soundId].
  ///
  /// The future completes once playback has been handed over to the system;
  /// pass [waitForCompletion] to await the end of the playback instead. Unknown
  /// IDs are silently ignored by iOS.
  Future<void> play(SystemSoundID soundId, {bool waitForCompletion = false}) {
    return _platform.play(soundId, waitForCompletion: waitForCompletion);
  }

  /// Plays a raw system sound ID, for IDs missing from the [SystemSoundID] enum.
  ///
  /// Throws an [ArgumentError] if [rawId] is not within `0...0xFFFFFFFF`.
  Future<void> playRawId(int rawId, {bool waitForCompletion = false}) {
    if (rawId < 0 || rawId > 0xFFFFFFFF) {
      throw ArgumentError.value(rawId, 'rawId', 'Must fit into UInt32.');
    }
    return _platform.playRawId(rawId, waitForCompletion: waitForCompletion);
  }

  /// Vibrates through `kSystemSoundID_Vibrate` (4095).
  ///
  /// Nothing happens on devices without a haptic engine.
  Future<void> vibrate({bool waitForCompletion = false}) {
    return _platform.playRawId(
      SystemSoundID.vibrate.value,
      waitForCompletion: waitForCompletion,
    );
  }
}
