import 'enum/ios_system_sounds.dart';
import 'ios_system_sound_platform_interface.dart';

export 'enum/ios_system_sounds.dart';

class IosSystemSound {
  Future<void> play(SystemSoundID soundId) {
    return IosSystemSoundPlatform.instance.play(soundId);
  }
}
