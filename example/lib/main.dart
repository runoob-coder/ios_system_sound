import 'package:flutter/cupertino.dart';
import 'package:ios_system_sound/ios_system_sound.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _iosSystemSoundPlugin = IosSystemSound();

  @override
  void initState() {
    super.initState();
  }

  void _onSoundTap(SystemSoundID soundId) {
    _iosSystemSoundPlugin.play(soundId);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        backgroundColor: CupertinoDynamicColor.resolve(
          CupertinoColors.systemGroupedBackground,
          context,
        ),
        child: CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text('iOS System Sound'),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 16.0,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              sliver: SliverToBoxAdapter(
                child: CupertinoFormSection.insetGrouped(
                  children: SystemSoundID.values.map((soundId) {
                    return CupertinoListTile(
                      title: Text(soundId.name),
                      subtitle: Text('ID: ${soundId.value}'),
                      trailing: CupertinoListTileChevron(),
                      onTap: () => _onSoundTap(soundId),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
