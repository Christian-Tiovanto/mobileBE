import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageLoader {
  final baseUrl = '127.0.0.1:3006';
  // Method to fetch image data as a stream
  Stream<Uint8List> loadImage(String endpoint) async* {
    try {
      String url =
          "http://172.17.0.140:3006/api/v1/teacher/67321c6e8881997bf9939764/photo";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        yield response.bodyBytes; // Emit image data as a stream
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error loading image: $e');
      yield Uint8List(0); // Emit empty data if an error occurs
    }
  }
}
