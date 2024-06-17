import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class FullScreenImage extends StatelessWidget {
  final File? selectedImage;
  const FullScreenImage({
  super.key,
  required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Center(
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained,
              imageProvider: FileImage(selectedImage!), // Display the selected image
              backgroundDecoration: BoxDecoration(color: Colors.black), // Background color
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop(); // Navigate back to previous screen
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}