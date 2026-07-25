import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:food_reg/core/themes/_themes.dart';

enum AppAlertType { success, error }

class _AppAlertStyle {
  const _AppAlertStyle({required this.accent, required this.icon});
  final Color accent;
  final IconData icon;
}

const _appAlertStyles = {
  AppAlertType.success: _AppAlertStyle(
    accent: BaseColors.primary,
    icon: Icons.check_rounded,
  ),
  AppAlertType.error: _AppAlertStyle(
    accent: BaseColors.red,
    icon: Icons.close_rounded,
  ),
};

/// The corners use a true quarter-ellipse bezier (the standard 0.5523
/// "kappa" constant, reverse-engineered from the reference's own cubic
/// control points)
class _AccentBarClipper extends CustomClipper<Path> {
  const _AccentBarClipper({required this.bodyWidth, required this.flareWidth});

  static const _kappa = 0.5523;

  final double bodyWidth;
  final double flareWidth;

  @override
  Path getClip(Size size) {
    final capHeight = math.min(8.0, size.height / 2);
    final rx = flareWidth - bodyWidth;
    final ry = capHeight;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(flareWidth, 0)
      ..cubicTo(
        flareWidth - _kappa * rx,
        0,
        bodyWidth,
        capHeight - _kappa * ry,
        bodyWidth,
        capHeight,
      )
      ..lineTo(bodyWidth, size.height - capHeight)
      ..cubicTo(
        bodyWidth,
        size.height - capHeight + _kappa * ry,
        flareWidth - _kappa * rx,
        size.height,
        flareWidth,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant _AccentBarClipper oldClipper) =>
      oldClipper.bodyWidth != bodyWidth || oldClipper.flareWidth != flareWidth;
}

OverlayEntry? _activeAlertEntry;
// Tracked alongside the entry so a new showAppAlert call can cancel the
// previous alert's auto-dismiss timer, not just remove its entry. Without
// this, a preempted alert's timer fires later and calls dismiss() on an
// already-removed OverlayEntry, which throws.
Timer? _activeAlertTimer;

/// Shows a compact top-right toast
/// — a colored accent bar and circular icon badge on a light card — instead
/// of the default bottom [SnackBar]. Auto-dismisses after [duration] or on
/// tapping the close button. Only one alert is shown at a time; a new call
/// replaces whatever is currently on screen rather than stacking.
void showAppAlert(
  BuildContext context, {
  required String message,
  required AppAlertType type,
  Duration duration = const Duration(seconds: 4),
}) {
  _activeAlertTimer?.cancel();
  _activeAlertEntry?.remove();
  _activeAlertEntry = null;
  _activeAlertTimer = null;

  // Read from the caller's context before the entry is inserted — the
  // overlay entry's own context is a sibling of the current route (not a
  // descendant), so it can't look up the calling page's Scaffold itself.
  final appBarHeight =
      Scaffold.maybeOf(context)?.appBarMaxHeight ?? kToolbarHeight;
  final overlay = Overlay.of(context, rootOverlay: true);
  late final OverlayEntry entry;
  Timer? dismissTimer;

  void dismiss() {
    dismissTimer?.cancel();
    if (identical(_activeAlertEntry, entry)) {
      _activeAlertEntry = null;
      _activeAlertTimer = null;
    }
    entry.remove();
  }

  entry = OverlayEntry(
    builder: (_) => _AppAlertOverlay(
      message: message,
      type: type,
      topOffset: appBarHeight,
      onClose: dismiss,
    ),
  );

  _activeAlertEntry = entry;
  overlay.insert(entry);
  dismissTimer = Timer(duration, dismiss);
  _activeAlertTimer = dismissTimer;
}

class _AppAlertOverlay extends StatefulWidget {
  const _AppAlertOverlay({
    required this.message,
    required this.type,
    required this.topOffset,
    required this.onClose,
  });

  final String message;
  final AppAlertType type;
  // Height of the calling page's app bar, so the alert sits below the
  // header instead of overlapping it.
  final double topOffset;
  final VoidCallback onClose;

  @override
  State<_AppAlertOverlay> createState() => _AppAlertOverlayState();
}

class _AppAlertOverlayState extends State<_AppAlertOverlay>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  late final _offset = Tween(
    begin: const Offset(0.25, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = _appAlertStyles[widget.type]!;
    return Positioned(
      top: MediaQuery.of(context).padding.top + widget.topOffset + 12,
      right: 16,
      left: 16,
      child: Align(
        alignment: Alignment.topRight,
        child: FadeTransition(
          opacity: _controller,
          child: SlideTransition(
            position: _offset,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Material(
                color: BaseColors.transparent,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEDEFEA), BaseColors.white],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: BaseColors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                      BoxShadow(
                        color: BaseColors.black.withValues(alpha: 0.06),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  // IntrinsicHeight so the Row below has a bounded height to
                  // stretch its children to — the accent bar needs to span
                  // the card's full height, and Row alone won't provide one.
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipPath(
                          clipper: const _AccentBarClipper(
                            bodyWidth: 6,
                            flareWidth: 10,
                          ),
                          child: Container(
                            key: const ValueKey('app_alert_accent_bar'),
                            width: 10,
                            color: style.accent,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(9, 12, 8, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: style.accent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    style.icon,
                                    size: 16,
                                    color: BaseColors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      widget.message,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: FontTheme.captionMedium.copyWith(
                                        color: const Color(0xFF525252),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: widget.onClose,
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 16,
                                      color: Color(0xFF262626),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
