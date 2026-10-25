import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_system_sound/ios_system_sound.dart';
import 'package:ios_system_sound_example/main.dart';
import 'package:ios_system_sound_example/src/unsupported_platform_banner.dart';

void main() {
  /// Scrolls the whole catalogue, collecting every text it renders.
  ///
  /// The list is lazily built, so one pump only contains the visible slice.
  Future<Set<String>> browse(WidgetTester tester) async {
    final rendered = <String>{};
    const scroll = Offset(0, -400);

    for (var step = 0; step < 40; step++) {
      for (final text in tester.widgetList<Text>(find.byType(Text))) {
        if (text.data case final label?) {
          rendered.add(label);
        }
      }
      await tester.drag(find.byType(Scrollable).first, scroll);
      await tester.pumpAndSettle();
    }
    return rendered;
  }

  testWidgets('renders the explorer chrome', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    expect(find.byType(CupertinoSliverNavigationBar), findsOneWidget);
    expect(find.byType(CupertinoSearchTextField), findsOneWidget);
    expect(find.text('Vibrate'), findsWidgets);
    expect(find.text('Camera shutter'), findsOneWidget);
  });

  testWidgets('keeps the search field pinned while scrolling', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -600));
    await tester.pumpAndSettle();

    // Still built, unlike the slivers that scrolled out of view above it.
    expect(find.byType(CupertinoSearchTextField), findsOneWidget);
  });

  testWidgets('renders every sound grouped by category', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    final rendered = await browse(tester);

    for (final category in SystemSoundCategory.values) {
      expect(rendered, contains(category.label));
    }
    for (final sound in SystemSoundID.values) {
      expect(rendered, contains(sound.name));
      expect(rendered, contains(contains(sound.value.toString())));
    }
  });

  testWidgets('filters the sounds through the search field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(CupertinoSearchTextField), 'shutter');
    await tester.pumpAndSettle();

    expect(find.text('photoShutter'), findsOneWidget);
    expect(find.text('sentMessage'), findsNothing);
  });

  testWidgets('finds a sound by its numeric id', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(CupertinoSearchTextField), '1108');
    await tester.pumpAndSettle();

    expect(find.text('photoShutter'), findsOneWidget);
    expect(find.text('newMail'), findsNothing);
  });

  testWidgets('plays a sound without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Camera shutter'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('warns when the sample does not run on iOS', (
    WidgetTester tester,
  ) async {
    debugDefaultTargetPlatformOverride = .macOS;
    try {
      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      expect(find.byType(UnsupportedPlatformBanner), findsOneWidget);

      // Interaction must stay safe outside of iOS (no-op instead of a crash).
      await tester.tap(find.text('Vibrate'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('hides the warning on iOS', (WidgetTester tester) async {
    debugDefaultTargetPlatformOverride = .iOS;
    try {
      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      expect(find.byType(UnsupportedPlatformBanner), findsNothing);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}
