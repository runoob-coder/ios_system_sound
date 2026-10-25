import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_system_sound/ios_system_sound.dart';
import 'package:ios_system_sound/ios_system_sound_method_channel.dart';
import 'package:ios_system_sound/ios_system_sound_platform_interface.dart';

class MockIosSystemSoundPlatform extends IosSystemSoundPlatform {
  final List<int> playedIds = [];
  final List<bool> waitFlags = [];

  @override
  Future<void> play(
    SystemSoundID soundId, {
    bool waitForCompletion = false,
  }) async {
    playedIds.add(soundId.value);
    waitFlags.add(waitForCompletion);
  }

  @override
  Future<void> playRawId(int rawId, {bool waitForCompletion = false}) async {
    playedIds.add(rawId);
    waitFlags.add(waitForCompletion);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$MethodChannelIosSystemSound', () {
    const MethodChannel channel = MethodChannel('ios_system_sound');

    late List<Map<String, Object?>> log;

    setUp(() {
      log = <Map<String, Object?>>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            log.add({
              'method': methodCall.method,
              'arguments': methodCall.arguments,
            });
            return null;
          });
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('is the default platform instance', () {
      expect(
        IosSystemSoundPlatform.instance,
        isInstanceOf<MethodChannelIosSystemSound>(),
      );
    });

    test('play() forwards the raw sound ID', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await MethodChannelIosSystemSound().play(SystemSoundID.photoShutter);

      expect(log, hasLength(1));
      expect(log.last['method'], 'play');
      expect(log.last['arguments'], {
        'soundId': 1108,
        'waitForCompletion': false,
      });

      debugDefaultTargetPlatformOverride = null;
    });

    test(
      'play(waitForCompletion: true) asks the native side to wait',
      () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        await MethodChannelIosSystemSound().play(
          SystemSoundID.photoShutter,
          waitForCompletion: true,
        );

        expect(log.last['arguments'], {
          'soundId': 1108,
          'waitForCompletion': true,
        });

        debugDefaultTargetPlatformOverride = null;
      },
    );

    test('playRawId() forwards arbitrary IDs', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await MethodChannelIosSystemSound().playRawId(4242);

      expect(log.last['arguments'], {
        'soundId': 4242,
        'waitForCompletion': false,
      });

      debugDefaultTargetPlatformOverride = null;
    });

    test('vibrate() plays kSystemSoundID_Vibrate', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await MethodChannelIosSystemSound().playRawId(
        SystemSoundID.vibrate.value,
      );

      expect(log.last['arguments'], {
        'soundId': 4095,
        'waitForCompletion': false,
      });

      debugDefaultTargetPlatformOverride = null;
    });

    test('is a no-op outside of iOS', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      await MethodChannelIosSystemSound().play(SystemSoundID.sentMessage);

      expect(log, isEmpty);

      debugDefaultTargetPlatformOverride = null;
    });

    test('propagates native failures', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
            throw PlatformException(code: 'INVALID_ARGS');
          });

      expect(
        () => MethodChannelIosSystemSound().playRawId(1),
        throwsA(isA<PlatformException>()),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('$IosSystemSound', () {
    late MockIosSystemSoundPlatform platform;
    late IosSystemSound sound;

    setUp(() {
      platform = MockIosSystemSoundPlatform();
      IosSystemSoundPlatform.instance = platform;
      sound = IosSystemSound();
    });

    test('play() delegates to the platform implementation', () async {
      await sound.play(SystemSoundID.unlock);

      expect(platform.playedIds, [1101]);
    });

    test('playRawId() delegates raw values', () async {
      await sound.playRawId(1027);

      expect(platform.playedIds, [1027]);
    });

    test('playRawId() rejects values outside of UInt32', () {
      expect(() => sound.playRawId(-1), throwsArgumentError);
      expect(() => sound.playRawId(0x100000000), throwsArgumentError);
    });

    test(
      'play(waitForCompletion:) reaches the platform implementation',
      () async {
        await sound.play(SystemSoundID.unlock, waitForCompletion: true);

        expect(platform.playedIds, [1101]);
        expect(platform.waitFlags, [true]);
      },
    );

    test('vibrate() uses kSystemSoundID_Vibrate (4095)', () async {
      await sound.vibrate();

      expect(platform.playedIds, [4095]);
    });
  });
}
