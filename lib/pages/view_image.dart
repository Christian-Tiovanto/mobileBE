import 'package:flutter/material.dart';
import 'package:mobile_be/main.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

class ViewFilePage extends StatefulWidget {
  final String assignmentId;
  final String fileName;

  ViewFilePage({required this.assignmentId, required this.fileName});

  @override
  _ViewFilePageState createState() => _ViewFilePageState();
}

class _ViewFilePageState extends State<ViewFilePage> {
  String _localPath = '';
  String _fileType = '';

  @override
  void initState() {
    super.initState();
    _downloadFile(widget.assignmentId, widget.fileName);
  }

  // Download the file and store it locally
  Future<void> _downloadFile(String assignmentId, String fileName) async {
    // Fetch the file data from your API using the assignmentId
    final response = await http.get(Uri.parse(
        "http://$baseHost:$basePort/api/v1/submission/$assignmentId/file"));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // You can attempt to get the mime type from the headers or rely on the response data
      final mimeType =
          lookupMimeType(response.headers['content-type']!, headerBytes: bytes);

      // Save the file locally
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      await file.writeAsBytes(bytes, flush: true);

      setState(() {
        _localPath = file.path;
        _fileType =
            mimeType ?? ''; // Store the file type (e.g., image, pdf, etc.)
      });
    } else {
      throw Exception("Failed to download file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('View File')),
        body: Center(
          child: _localPath.isEmpty
              ? CircularProgressIndicator() // Show loading indicator while downloading
              : _fileType.startsWith('image/') // If it's an image
                  ? PhotoView(
                      imageProvider: FileImage(File(_localPath)),
                    )
                  : _fileType == 'application/pdf' // If it's a PDF
                      ? SfPdfViewer.file(
                          File(_localPath),
                        )
                      : Center(child: Text('Unsupported file type')),
        ));
  }
}
