import 'package:flutter/cupertino.dart';

/// Informs the user that System Sound Services only exists on iOS, so every
/// other platform stays browsable but silent.
class UnsupportedPlatformBanner extends StatelessWidget {
  const UnsupportedPlatformBanner({super.key, required this.platform});

  /// The platform the example is currently running on.
  final TargetPlatform platform;

  @override
  Padding build(BuildContext context) {
    return .new(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CupertinoColors.systemYellow
              .resolveFrom(context)
              .withValues(alpha: 0.18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: CupertinoColors.systemYellow.resolveFrom(context),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Running on ${platform.name}. System sounds can only be '
                  'heard on a physical iOS device — playback is a no-op here.',
                  style: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.copyWith(fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
