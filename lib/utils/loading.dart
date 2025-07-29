import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class OnPullRefreshWidget extends StatefulWidget {
  const OnPullRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.imagePath,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final String imagePath;
  final Widget child;

  @override
  State<OnPullRefreshWidget> createState() => _OnPullRefreshWidgetState();
}

class _OnPullRefreshWidgetState extends State<OnPullRefreshWidget>
    with SingleTickerProviderStateMixin {
  double _pullDistance = 0.0;
  bool _isRefreshing = false;
  bool _canTriggerRefresh = false;

  bool _didTriggerHapticFeedback = false;
  // Removed _didTriggerBounce as the bounce effect was complex and might interfere with reset logic

  late AnimationController _animationController; // Renamed for clarity, used for reset/bounce
  late Animation<double> _pullAnimation;

  static const double _refreshThreshold = 80.0;
  static const double _indicatorAreaHeight = 70.0;
  // Max pull distance to prevent extreme values from overscroll
  static const double _maxPullDistance = _refreshThreshold + 40.0;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250), // Default duration for reset
    )..addListener(() {
      if (mounted && !_isRefreshing) { // Only apply animation if not in a forced refresh state
        setState(() {
          _pullDistance = _pullAnimation.value;
        });
      }
    });
    _pullAnimation = const AlwaysStoppedAnimation(0.0);
  }

  Future<void> _handleRefresh() async {
    if (!mounted || _isRefreshing) return;

    HapticFeedback.mediumImpact(); // Haptic feedback on refresh trigger

    setState(() {
      _isRefreshing = true;
      _canTriggerRefresh = false; // Prevent re-triggering
      // Ensure the indicator stays visible during refresh
      // If pullDistance was > threshold, it will stay via showActiveIndicator.
      // If it was exactly at threshold, ensure it's visually "active".
      if (_pullDistance < _refreshThreshold) {
        _pullDistance = _refreshThreshold; // Or set to indicatorAreaHeight if that's preferred
      }
    });

    // try {
      await widget.onRefresh();
    // } catch (e) {
    //   debugPrint("Error during onRefresh: $e");
    // }

    if (!mounted) return;

    setState(() {
      _isRefreshing = false;
      // _pullDistance will be animated to 0 by _animateResetNow
    });
    _animateResetNow(); // Animate indicator away and reset pull distance
  }

  void _animateResetNow({double? from}) {
    if (_isRefreshing && from == null) return; // Don't auto-reset if a refresh just started

    _animationController.duration = const Duration(milliseconds: 250); // Standard reset duration
    _pullAnimation = Tween<double>(
      begin: from ?? _pullDistance,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward(from: 0.0);
    _didTriggerHapticFeedback = false; // Reset feedback flag
  }

  // Simplified bounce, or remove if it complicates things too much
  void _triggerPullFeedbackAndBounce() {
    if (_didTriggerHapticFeedback) return;
    HapticFeedback.mediumImpact();
    _didTriggerHapticFeedback = true;

    // Simple bounce animation
    final double currentPull = _pullDistance;
    _animationController.duration = const Duration(milliseconds: 150);
    _pullAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: currentPull, end: currentPull + 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: currentPull + 10, end: currentPull), weight: 1),
    ]).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward(from:0.0).then((_) {
      // Ensure animation doesn't stick if interrupted
      if (!_isRefreshing && !_canTriggerRefresh && _animationController.isCompleted) {
        // If not going to refresh, ensure it settles back to the actual pull or zero
        if (mounted && _pullDistance > 0 && _pullDistance < _refreshThreshold) {
          // No, this would fight with user dragging. Bounce is visual only.
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // Determines if the indicator shows its "active" state (fully pulled or refreshing)
    final bool showActiveUI = _isRefreshing || (_canTriggerRefresh && _pullDistance >= _refreshThreshold);

    return Stack(
      clipBehavior: Clip.none, // Allow indicator to potentially draw outside bounds if animated that way
      children: [
        // Refresh image or shimmer
        // Positioned ensures it's at the top, behind the Column initially if height is 0
        if (_pullDistance > 0 || _isRefreshing) // Show if any pull or refreshing
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _indicatorAreaHeight,
            child: Center(
              child: _isRefreshing
                  ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Image.asset(widget.imagePath,
                    height: 50, fit: BoxFit.contain),
              )
                  : Opacity(
                opacity: (_pullDistance / _refreshThreshold).clamp(0.0, 1.0),
                child: Image.asset(
                  widget.imagePath,
                  height: (_pullDistance / _refreshThreshold * 50.0)
                      .clamp(0.0, 50.0), // Scale image with pull
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth != 0) return true; // Only main scroll view
            if (_isRefreshing && notification is! ScrollEndNotification && notification is! UserScrollNotification) {
              return true;
            }

            if (notification is ScrollStartNotification) {
              _animationController.stop();
              _didTriggerHapticFeedback = false;
            } else if (notification is ScrollUpdateNotification) {
              if (notification.dragDetails != null) { // User is dragging
                double newPull = _pullDistance;
                // This handles iOS-style pull or BouncingScrollPhysics where pixels go negative
                if (notification.metrics.pixels <= 0) {
                  newPull = -notification.metrics.pixels;
                }
                // If NOT using BouncingScrollPhysics on Android, this `else if` might be where
                // you'd try to estimate pull from `notification.dragDetails.delta.dy` if pixels don't go negative,
                // but that can be more complex. For now, we primarily rely on negative pixels or the OverscrollNotification.

                // If user scrolls back up into content area
                else if (notification.metrics.pixels > 0 && _pullDistance > 0) {
                  newPull = 0; // Reset if scrolled back into view from a pull
                }


                newPull = newPull.clamp(0.0, _maxPullDistance);

                if ((newPull - _pullDistance).abs() > 0.1 || (newPull == 0 && _pullDistance !=0) ) {
                  setState(() {
                    _pullDistance = newPull;
                    _canTriggerRefresh = _pullDistance >= _refreshThreshold;
                  });
                }

                if (_pullDistance >= _refreshThreshold && !_didTriggerHapticFeedback) {
                  _triggerPullFeedbackAndBounce();
                } else if (_pullDistance < _refreshThreshold) {
                  _didTriggerHapticFeedback = false;
                }
              }
            } else if (notification is OverscrollNotification) {
              // This is primarily for Android's glow effect when pixels don't go negative.
              if (notification.dragDetails != null && notification.overscroll > 0 && !_isRefreshing && Theme.of(context).platform == TargetPlatform.android) {
                // Only add to pullDistance if we are at the top (pixels are 0 or close to it)
                // and the drag is ongoing.
                if (notification.metrics.pixels == 0) { // Or very close to 0
                  double newPull = _pullDistance + (notification.overscroll * 0.4); // Dampened accumulation
                  newPull = newPull.clamp(0.0, _maxPullDistance);
                  if ((newPull - _pullDistance).abs() > 0.1) {
                    setState(() {
                      _pullDistance = newPull;
                      _canTriggerRefresh = _pullDistance >= _refreshThreshold;
                    });
                  }
                  if (_pullDistance >= _refreshThreshold && !_didTriggerHapticFeedback) {
                    _triggerPullFeedbackAndBounce();
                  }
                }
              }
            } else if (notification is ScrollEndNotification ||
                (notification is UserScrollNotification &&
                    notification.direction == ScrollDirection.idle)) {
              if (_canTriggerRefresh && !_isRefreshing) {
                _handleRefresh();
              } else if (!_isRefreshing) {
                _animateResetNow();
              }
            }
            return true;
          },
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: showActiveUI ? _indicatorAreaHeight : 0,
              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}