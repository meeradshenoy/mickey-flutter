import 'dart:math';

import 'package:flutter/material.dart';
import 'package:micky/blob.dart';

import 'color_pallete.dart';

// A Flutter StatefulWidget that represents an animated assistant icon
class AnimatedAssistantIcon extends StatefulWidget {
  final bool animate; // Indicates whether the icon should be animated

  const AnimatedAssistantIcon({super.key, required this.animate});

  @override
  AnimatedAssistantIconState createState() => AnimatedAssistantIconState();
}

class AnimatedAssistantIconState extends State<AnimatedAssistantIcon>
    with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying; // Indicates whether the animation is playing

  // Animation controllers for rotation and scaling
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0; // Current rotation value in radians
  double _scale = 0.85; // Current scaling factor

  // Getter to determine whether to show the animated waves
  bool get _showWaves => !_scaleController.isDismissed;

  // Update rotation based on the current value of the rotation controller
  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;

  // Update scaling based on the current value of the scale controller
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 1;

  @override
  void initState() {
    isPlaying = widget.animate;

    // Initializing rotation animation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: _kRotationDuration,
    )
      ..addListener(() => setState(_updateRotation))
      ..repeat();

    // Initializing scale animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: _kToggleDuration,
    )..addListener(() => setState(_updateScale));

    super.initState();
  }

  // Handler for toggling the animation
  void _onToggle() {
    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
  }

  // Builds the icon based on whether the animation is playing
  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorPallete.assistantCircleColor,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/virtualAssistant.png'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Triggering animation when widget is built
    if (widget.animate) {
      _onToggle();
    } else {
      // Reversing the scale animation if not in animate mode
      if (_scaleController.isCompleted) {
        _scaleController.reverse();
      }
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            // Displaying animated waves using Blob widget
            Blob(
              color: ColorPallete.firstSuggestionBoxColor,
              scale: _scale,
              rotation: _rotation,
            ),
            Blob(
              color: ColorPallete.secondSuggestionBoxColor,
              scale: _scale,
              rotation: _rotation * 2 - 30,
            ),
            Blob(
              color: ColorPallete.thirdSuggestionBoxColor,
              scale: _scale,
              rotation: _rotation * 3 - 45,
            ),
          ],
          // Container for the main icon with AnimatedSwitcher for smooth transitions
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: AnimatedSwitcher(
              duration: _kToggleDuration,
              child: _buildIcon(isPlaying),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Disposing animation controllers to free up resources
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}
