import 'package:flutter_test/flutter_test.dart';
import 'package:ios_system_sound/ios_system_sound.dart';
import 'package:ios_system_sound/ios_system_sound_method_channel.dart';
import 'package:ios_system_sound/ios_system_sound_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosSystemSoundPlatform
    with MockPlatformInterfaceMixin
    implements IosSystemSoundPlatform {
  @override
  Future<void> play(SystemSoundID soundID) {
    // TODO: implement play
    throw UnimplementedError();
  }
}

void main() {
  final IosSystemSoundPlatform initialPlatform =
      IosSystemSoundPlatform.instance;

  test('$MethodChannelIosSystemSound is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosSystemSound>());
  });
}
