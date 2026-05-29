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
  Future<void> play(SystemSoundID soundId) async {
    try {
      await methodChannel.invokeMethod('play', {'soundId': soundId.value});
    } catch (e) {
      print("调用原生方法失败: $e");
    }
  }
}
