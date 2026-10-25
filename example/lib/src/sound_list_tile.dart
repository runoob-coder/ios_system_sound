import 'package:flutter/cupertino.dart';
import 'package:ios_system_sound/ios_system_sound.dart';

/// A row for one predefined system sound; tapping it plays the sample and
/// highlights the leading badge as visual feedback.
class SoundListTile extends StatelessWidget {
  const SoundListTile({
    super.key,
    required this.soundId,
    required this.isPlaying,
    required this.onPlay,
  });

  /// The sound rendered by this tile.
  final SystemSoundID soundId;

  /// Whether the sound is currently being played.
  final bool isPlaying;

  /// Called when the tile is tapped.
  final ValueChanged<SystemSoundID> onPlay;

  @override
  CupertinoListTile build(BuildContext context) {
    final foreground = isPlaying
        ? CupertinoColors.white
        : CupertinoColors.secondaryLabel.resolveFrom(context);

    return .new(
      onTap: () => onPlay(soundId),
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 28.0,
        height: 28.0,
        decoration: BoxDecoration(
          shape: .circle,
          color: isPlaying
              ? CupertinoColors.activeBlue
              : CupertinoColors.systemGrey5.resolveFrom(context),
        ),
        child: Icon(
          CupertinoIcons.play_arrow_solid,
          size: 16.0,
          color: foreground,
        ),
      ),
      title: Text(soundId.name),
      subtitle: Text('${soundId.value} · $_subtitle'),
      trailing: const CupertinoListTileChevron(),
    );
  }

  String get _subtitle {
    return switch (soundId.category) {
      .vibration => 'vibration only',
      _ => soundId.category.label,
    };
  }
}
