import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_be/services/image-loader.dart';

class ImageStreamWidget extends StatelessWidget {
  final String imageUrl;

  ImageStreamWidget({required this.imageUrl});

  final ImageLoader _imageLoader = ImageLoader();

  @override
  Widget build(BuildContext context) {
    print('imageUrl di streamwidget');
    print(imageUrl);
    return StreamBuilder<Uint8List>(
      stream: _imageLoader.loadImage(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error loading image'); // Display an error message if loading fails
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Image.memory(snapshot.data!); // Display the image from bytes
        } else {
          return Text('No image available'); // Fallback if no image data
        }
      },
    );
  }
}
