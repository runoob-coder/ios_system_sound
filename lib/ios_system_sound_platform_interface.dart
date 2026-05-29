import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enum/ios_system_sounds.dart';
import 'ios_system_sound_method_channel.dart';

abstract class IosSystemSoundPlatform extends PlatformInterface {
  /// Constructs a IosSystemSoundPlatform.
  IosSystemSoundPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosSystemSoundPlatform _instance = MethodChannelIosSystemSound();

  /// The default instance of [IosSystemSoundPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosSystemSound].
  static IosSystemSoundPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosSystemSoundPlatform] when
  /// they register themselves.
  static set instance(IosSystemSoundPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> play(SystemSoundID soundId) {
    throw UnimplementedError(
      'play() is iOS platform specific method which is not implemented',
    );
  }
}
