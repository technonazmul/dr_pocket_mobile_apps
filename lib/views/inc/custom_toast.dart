import 'package:flutter/material.dart';
import 'dart:async'; // For using Timer

void showCustomToast(BuildContext context, String message) {
  // OverlayEntry allows us to insert a widget on top of the widget tree
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      // Position the toast at the bottom of the screen
      bottom: 50.0,
      left: MediaQuery.of(context).size.width * 0.2, // Center horizontally
      width: MediaQuery.of(context).size.width * 0.6,
      child: Material(
        color: Colors.transparent, // So it blends with the background
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8), // Background color
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the toast into the widget tree
  Overlay.of(context).insert(overlayEntry);

  // Remove the toast after a delay (2 seconds in this case)
  Timer(const Duration(seconds: 2), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
