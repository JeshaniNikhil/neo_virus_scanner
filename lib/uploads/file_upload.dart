import 'dart:convert';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:virus_scanner/file_analysis/file_result.dart';
class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {

  int _currentIndex = 0;
  Color iconColor = Colors.white;

  // Function to upload file and send it to VirusTotal API
  Future<void> _uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);

        // Show a loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // VirusTotal API key
        const String apiKey = 'cbbbb85ceea6a1f9a2403fb861d86e06a7418d768371552780aeb73caca67582';
        const String url = 'https://www.virustotal.com/api/v3/files';

        // Create multipart request
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll({'x-apikey': apiKey});
        request.files.add(await http.MultipartFile.fromPath('file', file.path));

        // Send request and await response
        var response = await request.send();

        // Close the loading dialog
        Navigator.of(context).pop();

        if (response.statusCode == 200) {
          var responseBody = await http.Response.fromStream(response);
          var responseData = json.decode(responseBody.body);
          var analysisToken = responseData['data']['id'];

          // Navigate to Scan Results Screen with the token
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanResultsScreen(analysisToken: analysisToken),
            ),
          );
        } else {
          _showResponseDialog('File upload failed. Please try again.');
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      _showResponseDialog('An error occurred while uploading the file.');
    }
  }


  // Function to show response dialog
  void _showResponseDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neon Scanner Response'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E38),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E38),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              "NeoVirus Scanner",
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Neon',
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "File Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Upload your files for scanning",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _uploadFile,
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 10,
                              left: 10,
                              child: Icon(
                                Icons.folder_open,
                                color: Colors.blueAccent,
                                size: 45,
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/file_upload.svg',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Click to upload file",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.deepPurple,
        items: [
          Icon(color: iconColor, Icons.home, size: 30),
          Icon(color: iconColor, Icons.search, size: 30),
          Icon(color: iconColor, Icons.notifications, size: 30),
          Icon(color: iconColor, Icons.person_2_outlined, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
