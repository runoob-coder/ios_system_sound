import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enum/ios_system_sounds.dart';
import 'ios_system_sound_method_channel.dart';

/// The interface that platform implementations of the plugin must implement.
///
/// Extend this class rather than implementing it, so methods added later do not
/// break existing implementations; `extends` is enforced at runtime by
/// [PlatformInterface].
abstract class IosSystemSoundPlatform extends PlatformInterface {
  IosSystemSoundPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosSystemSoundPlatform _instance = MethodChannelIosSystemSound();

  /// The platform implementation in use, [MethodChannelIosSystemSound] by
  /// default.
  static IosSystemSoundPlatform get instance => _instance;

  /// Replaces [instance] with a platform-specific implementation.
  static set instance(IosSystemSoundPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Plays a predefined [soundId].
  ///
  /// With [waitForCompletion] the future completes only after the sound has
  /// finished playing.
  Future<void> play(SystemSoundID soundId, {bool waitForCompletion = false}) {
    throw UnimplementedError(
      'play() is iOS platform specific method which is not implemented',
    );
  }

  /// Plays a raw `SystemSoundID` value, for IDs missing from the enum.
  ///
  /// With [waitForCompletion] the future completes only after the sound has
  /// finished playing.
  Future<void> playRawId(int rawId, {bool waitForCompletion = false}) {
    throw UnimplementedError(
      'playRawId() is iOS platform specific method which is not implemented',
    );
  }
}
