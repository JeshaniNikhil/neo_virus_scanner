import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

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
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    if (widget.analysisToken.isNotEmpty) {
      fetchScanResults();
    }
  }

  Future<void> fetchScanResults() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    const apiKey = 'cbbbb85ceea6a1f9a2403fb861d86e06a7418d768371552780aeb73caca67582';
    final apiUrl = 'https://www.virustotal.com/api/v3/analyses/${widget.analysisToken}';

    try {
      bool analysisComplete = false;
      int retryCount = 0;
      const maxRetries = 10;

      while (!analysisComplete && retryCount < maxRetries) {
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {'x-apikey': apiKey},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];
          final attributes = data['attributes'];
          final status = attributes['status'];

          // Check if analysis is completed
          if (status == 'completed') {
            analysisComplete = true;
            final stats = attributes['stats'];
            final results = attributes['results'];

            setState(() {
              maliciousCount = stats['malicious'] ?? 0;
              undetectedCount = stats['undetected'] ?? 0;
              unsupportedCount = stats['type-unsupported'] ?? 0;
              detailedResults = results;
              isLoading = false;
            });
          } else {
            // Wait for 3 seconds before retrying
            await Future.delayed(const Duration(seconds: 3));
            retryCount++;
          }
        } else {
          setState(() {
            errorMessage = 'Failed to fetch results. Status code: ${response.statusCode}';
            isLoading = false;
          });
          break;
        }
      }

      if (!analysisComplete) {
        setState(() {
          errorMessage = 'Analysis timed out. Please try again later.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error occurred: $e';
        isLoading = false;
      });
    }
  }

  Widget _buildSummaryCard(String title, int count, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Scan Results'),
        backgroundColor: const Color(0xFF2C2C2E),
        elevation: 0,
      ),
      body: Platform.isAndroid
          ? RepaintBoundary(
              child: _buildBody(),
            )
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return isLoading 
      ? const Center(child: CircularProgressIndicator())
      : errorMessage.isNotEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: fetchScanResults,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: fetchScanResults,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildSummaryCard('Malicious', maliciousCount, Colors.red),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSummaryCard('Clean', undetectedCount, Colors.green),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSummaryCard('Unsupported', unsupportedCount, Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 50,
                          sections: [
                            PieChartSectionData(
                              value: maliciousCount.toDouble(),
                              color: Colors.red.withOpacity(0.8),
                              title: 'Malicious\n${maliciousCount}',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              badgeWidget: const Icon(Icons.warning, color: Colors.white, size: 20),
                              badgePositionPercentageOffset: 1.2,
                            ),
                            PieChartSectionData(
                              value: undetectedCount.toDouble(),
                              color: Colors.green.withOpacity(0.8),
                              title: 'Clean\n${undetectedCount}',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              badgeWidget: const Icon(Icons.check_circle, color: Colors.white, size: 20),
                              badgePositionPercentageOffset: 1.2,
                            ),
                            PieChartSectionData(
                              value: unsupportedCount.toDouble(),
                              color: Colors.orange.withOpacity(0.8),
                              title: 'Unsupported\n${unsupportedCount}',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              badgeWidget: const Icon(Icons.help_outline, color: Colors.white, size: 20),
                              badgePositionPercentageOffset: 1.2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Detailed Analysis Results',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: const Color(0xFF2C2C2E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: detailedResults.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          color: Color(0xFF3C3C3E),
                        ),
                        itemBuilder: (context, index) {
                          final engineName = detailedResults.keys.elementAt(index);
                          final engineDetails = detailedResults[engineName];
                          final result = engineDetails['result'] ?? 'Clean';
                          final category = engineDetails['category'] ?? 'unknown';

                          return ListTile(
                            leading: Icon(
                              result == 'Clean' ? Icons.check_circle : Icons.warning,
                              color: result == 'Clean' ? Colors.green : Colors.red,
                              size: 28,
                            ),
                            title: Text(
                              engineName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Result: $result',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'Category: $category',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
