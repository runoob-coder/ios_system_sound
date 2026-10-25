import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ios_system_sound/ios_system_sound.dart';

import 'sound_list_tile.dart';
import 'unsupported_platform_banner.dart';

/// Browses every predefined [SystemSoundID], grouped by [SystemSoundCategory].
class SoundExplorerScreen extends StatefulWidget {
  const SoundExplorerScreen({super.key});

  @override
  State<SoundExplorerScreen> createState() => _SoundExplorerScreenState();
}

class _SoundExplorerScreenState extends State<SoundExplorerScreen> {
  /// Gap between two samples, so short sounds stay distinguishable.
  static const Duration _sampleDelay = Duration(milliseconds: 500);

  /// Safety net: an unknown ID may never report completion and stall the run.
  static const Duration _sampleTimeout = Duration(seconds: 5);

  final IosSystemSound _sound = IosSystemSound();
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  SystemSoundID? _lastPlayed;
  String? _error;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _isIOS => defaultTargetPlatform == .iOS;

  /// All categories that still have at least one visible match.
  List<SystemSoundCategory> get _visibleCategories {
    final grouped = SystemSoundID.byCategory;
    return SystemSoundCategory.values
        .where((category) => _filtered(grouped[category]!).isNotEmpty)
        .toList();
  }

  List<SystemSoundID> _filtered(List<SystemSoundID> sounds) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return sounds;
    }
    return sounds.where((sound) => _matches(sound, query)).toList();
  }

  bool _matches(SystemSoundID sound, String query) {
    return sound.name.toLowerCase().contains(query) ||
        sound.value.toString().contains(query) ||
        sound.category.label.toLowerCase().contains(query);
  }

  Future<void> _play(
    SystemSoundID sound, {
    bool waitForCompletion = false,
  }) async {
    setState(() {
      _lastPlayed = sound;
      _error = null;
    });
    try {
      await _sound.play(sound, waitForCompletion: waitForCompletion);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = '$error');
    }
  }

  Future<void> _vibrate() async {
    setState(() => _error = null);
    try {
      await _sound.vibrate();
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = '$error');
    }
  }

  /// Plays every sound of a category one after another: each sample runs to
  /// completion, then waits [_sampleDelay] before the next one starts.
  Future<void> _playSequence(List<SystemSoundID> sounds) async {
    for (var index = 0; index < sounds.length; index++) {
      if (!mounted) {
        return;
      }
      await _play(
        sounds[index],
        waitForCompletion: true,
      ).timeout(_sampleTimeout, onTimeout: () {});
      if (!mounted || index == sounds.length - 1) {
        return;
      }
      await Future<void>.delayed(_sampleDelay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _visibleCategories;
    final grouped = SystemSoundID.byCategory;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(
        context,
      ),
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('iOS System Sound'),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedSearchBar(child: _buildSearchField()),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (!_isIOS)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: UnsupportedPlatformBanner(
                      platform: defaultTargetPlatform,
                    ),
                  ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _buildError(),
                  ),
              ],
            ),
          ),
          if (_query.isEmpty) SliverToBoxAdapter(child: _buildActionsSection()),
          ...categories.map(
            (category) => SliverToBoxAdapter(
              child: _buildCategorySection(
                context,
                category,
                grouped[category]!,
              ),
            ),
          ),
          if (categories.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No sound matches "$_query".',
                  style: TextStyle(
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
            )
          else
            const SliverToBoxAdapter(child: SizedBox(height: 32.0)),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
      child: CupertinoSearchTextField(
        controller: _searchController,
        placeholder: 'Search by name, category or ID',
        onChanged: (value) => setState(() => _query = value),
      ),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        _error!,
        style: const TextStyle(color: CupertinoColors.destructiveRed),
      ),
    );
  }

  Widget _buildActionsSection() {
    return CupertinoListSection.insetGrouped(
      children: [
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.padlock_solid),
          title: const Text('Vibrate'),
          subtitle: Text(
            '${SystemSoundID.vibrate.value} · kSystemSoundID_Vibrate',
          ),
          onTap: _vibrate,
        ),
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.waveform),
          title: const Text('Camera shutter'),
          subtitle: Text(
            '${SystemSoundID.photoShutter.value} · ${SystemSoundID.photoShutter.category.label}',
          ),
          trailing: const CupertinoListTileChevron(),
          onTap: () => _play(SystemSoundID.photoShutter),
        ),
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    SystemSoundCategory category,
    List<SystemSoundID> sounds,
  ) {
    final visible = _filtered(sounds);

    return CupertinoListSection.insetGrouped(
      header: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(category.label),
          CupertinoButton(
            minimumSize: const Size.square(0),
            padding: EdgeInsets.zero,
            onPressed: () => _playSequence(visible),
            child: const Text('Play all'),
          ),
        ],
      ),
      footer: const SizedBox.shrink(),
      children: visible
          .map(
            (sound) => SoundListTile(
              soundId: sound,
              isPlaying: _lastPlayed == sound,
              onPlay: _play,
            ),
          )
          .toList(growable: false),
    );
  }
}

/// Docks the search field under the navigation bar so it stays reachable while
/// the catalogue scrolls underneath it.
class _PinnedSearchBar extends SliverPersistentHeaderDelegate {
  const _PinnedSearchBar({required this.child});

  /// Height of a `CupertinoSearchTextField` (36) plus the padding around it.
  static const double extent = 56.0;

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
        border: shrinkOffset > 0
            ? Border(
                bottom: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: SizedBox(height: extent, child: child),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(covariant _PinnedSearchBar oldDelegate) =>
      oldDelegate.child != child;
}
