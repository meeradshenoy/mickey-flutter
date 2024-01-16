import 'package:flutter/material.dart';

// A custom Flutter widget representing a blob with rotation, scaling, and color properties
class Blob extends StatelessWidget {
  // Properties to customize the blob
  final double rotation; // Rotation angle in radians
  final double scale; // Scaling factor
  final Color color; // Background color of the blob

  const Blob({
    super.key,
    required this.color,
    this.rotation = 0, // Default rotation angle is 0
    this.scale = 1, // Default scaling factor is 1
  });

  @override
  Widget build(BuildContext context) {
    // Applying scaling and rotation transformations to the container
    return Transform.scale(
      scale: scale, // Setting the scaling factor
      child: Transform.rotate(
        angle: rotation, // Setting the rotation angle
        child: Container(
          decoration: BoxDecoration(
            color: color, // Setting the background color
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ), // Applying custom border radius to create blob shape
          ),
        ),
      ),
    );
  }
}
