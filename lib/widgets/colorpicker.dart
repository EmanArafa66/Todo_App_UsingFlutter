// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// A stateless widget that represents a color picker dialog
class ColorPickerDialog extends StatelessWidget {
  final Color initialColor; // The initial color selected in the dialog

  ColorPickerDialog(
      {required this.initialColor}); // Constructor to accept the initial color

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor; // Variable to store the selected color

    return AlertDialog(
      title: Text('Pick a Color'), // Title of the dialog
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: initialColor, // Initial color
          onColorChanged: (color) {
            selectedColor = color; // Update selected color
          },
          showLabel: true, // Show color label
          pickerAreaHeightPercent: 0.8, // Height of the color picker area
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, selectedColor); // Return the selected color
          },
          child: Text('Select'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Cancel the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
