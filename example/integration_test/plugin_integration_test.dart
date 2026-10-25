import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ios_system_sound/ios_system_sound.dart';
import 'package:ios_system_sound_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final sound = IosSystemSound();

  testWidgets('plays a tapped sound through the UI', (
    WidgetTester tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.text('newMail'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('plays every audible sound of the alerts category', (
    WidgetTester tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    final alerts = SystemSoundID.byCategory[SystemSoundCategory.alert]!;
    for (final soundId in alerts) {
      await sound.play(soundId);
    }
  });

  testWidgets('triggers vibration', (WidgetTester tester) async {
    await sound.vibrate();
  });
}
