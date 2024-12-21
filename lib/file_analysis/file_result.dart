import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VirusScanApp extends StatelessWidget {
  const VirusScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScanResultsScreen(analysisToken: '',),
      theme: ThemeData.dark(),
    );
  }
}

class ScanResultsScreen extends StatefulWidget {
  final String analysisToken;

  const ScanResultsScreen({super.key, required this.analysisToken});

  @override
  _ScanResultsScreenState createState() => _ScanResultsScreenState();
}

class _ScanResultsScreenState extends State<ScanResultsScreen> {
  int maliciousCount = 0;
  int undetectedCount = 0;
  int unsupportedCount = 0;
  Map<String, dynamic> detailedResults = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchScanResults();
  }

  Future<void> fetchScanResults() async {
    const apiKey = 'cbbbb85ceea6a1f9a2403fb861d86e06a7418d768371552780aeb73caca67582';
    final apiUrl = 'https://www.virustotal.com/api/v3/analyses/${widget.analysisToken}';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-apikey': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final attributes = data['attributes'];
        final stats = attributes['stats'];
        final results = attributes['results'];

        setState(() {
          maliciousCount = stats['malicious'];
          undetectedCount = stats['undetected'];
          unsupportedCount = stats['type-unsupported'];
          detailedResults = results;
          isLoading = false;
        });
      } else {
        print('Error: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching scan results: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Results'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Scan Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: maliciousCount.toDouble(),
                        color: Colors.red,
                        title: 'Malicious',
                      ),
                      PieChartSectionData(
                        value: undetectedCount.toDouble(),
                        color: Colors.blue,
                        title: 'Undetected',
                      ),
                      PieChartSectionData(
                        value: unsupportedCount.toDouble(),
                        color: Colors.orange,
                        title: 'Unsupported',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Summary',
                style: TextStyle(fontSize: 18),
              ),
              Text('Malicious: $maliciousCount'),
              Text('Undetected: $undetectedCount'),
              Text('Unsupported: $unsupportedCount'),
              const SizedBox(height: 20),
              const Text(
                'Detailed Results',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: detailedResults.length,
                itemBuilder: (context, index) {
                  final engineName = detailedResults.keys.elementAt(index);
                  final engineDetails = detailedResults[engineName];
                  final result = engineDetails['result'] ?? 'No threat';

                  return ListTile(
                    leading: Icon(
                      result == 'No threat' ? Icons.check_circle : Icons.warning,
                      color: result == 'No threat' ? Colors.green : Colors.red,
                    ),
                    title: Text(engineName),
                    subtitle: Text(result),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

