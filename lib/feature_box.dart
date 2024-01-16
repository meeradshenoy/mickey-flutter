import 'package:flutter/material.dart';
import 'package:micky/color_pallete.dart';

// A custom Flutter widget representing a feature box with colored background, header text, and description text
class FeatureBox extends StatelessWidget {
  // Properties to customize the feature box
  final Color color; // Background color of the feature box
  final String headerText; // Text to be displayed as the header
  final String descriptionText; // Text to be displayed as the description

  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: color, // Setting the background color
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              headerText, // Displaying the header text
              style: const TextStyle(
                  fontFamily: 'SourceCodePro',
                  color: ColorPallete.blackColor, // Text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold), // Styling for the header text
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            descriptionText, // Displaying the description text
            style: const TextStyle(
                fontFamily: 'SourceCodePro',
                color: ColorPallete.blackColor, // Text color
                fontSize: 14),
          )
        ],
      ),
    );
  }
}
