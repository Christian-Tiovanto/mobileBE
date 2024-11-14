import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_be/main.dart';

class ImageLoader {
  // Method to fetch image data as a stream
  Stream<Uint8List> loadImage(String endpoint) async* {
    try {
      String url = "http://$baseHost:$basePort$endpoint";
      print('url di imageloader');
      print(url);
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
