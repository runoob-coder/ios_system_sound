import 'package:flutter/cupertino.dart';

import 'src/sound_explorer_screen.dart';

void main() {
  runApp(const ExampleApp());
}

/// Example app demonstrating the `ios_system_sound` plugin.
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'iOS System Sound',
      home: SoundExplorerScreen(),
    );
  }
}
