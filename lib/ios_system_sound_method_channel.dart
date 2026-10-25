import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'enum/ios_system_sounds.dart';
import 'ios_system_sound_platform_interface.dart';

/// An implementation of [IosSystemSoundPlatform] that uses method channels.
class MethodChannelIosSystemSound extends IosSystemSoundPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_system_sound');

  @override
  Future<void> play(SystemSoundID soundId, {bool waitForCompletion = false}) {
    return playRawId(soundId.value, waitForCompletion: waitForCompletion);
  }

  @override
  Future<void> playRawId(int rawId, {bool waitForCompletion = false}) async {
    if (!_isSupportedPlatform) {
      // System Sound Services only exists on iOS: ignore instead of failing, so
      // cross-platform widgets can share one code path.
      debugPrint('ios_system_sound: ignored on ${defaultTargetPlatform.name}.');
      return;
    }

    await methodChannel.invokeMethod<void>('play', {
      'soundId': rawId,
      'waitForCompletion': waitForCompletion,
    });
  }

  /// Whether the current build actually has an iOS platform channel attached.
  bool get _isSupportedPlatform => defaultTargetPlatform == .iOS;
}
