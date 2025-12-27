import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import 'package:intl/intl.dart';
import '../auth/auth_provider.dart';
import '../utils/error_utils.dart';

class RecentPlaysScreen extends StatefulWidget {
  const RecentPlaysScreen({super.key});

  @override
  State<RecentPlaysScreen> createState() => _RecentPlaysScreenState();
}

class _RecentPlaysScreenState extends State<RecentPlaysScreen> {
  late VinylApi _vinylApi;
  List<TrackPlay> _plays = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _vinylApi = VinylApi(context.read<AuthProvider>().apiClient);
    _fetchRecentPlays();
  }

  Future<void> _fetchRecentPlays() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _vinylApi.getRecentPlaysRoute(limit: 50);
      setState(() {
        _plays = response?.plays ?? [];
        _isLoading = false;
      });
    } catch (e) {
      final errorMessage = e.toString();
      setState(() {
        _error = errorMessage;
        _isLoading = false;
      });
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Failed to load history: $errorMessage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Plays'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchRecentPlays,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null && _plays.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: $_error'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _fetchRecentPlays,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : _plays.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No recent plays found.'),
                            Text('Start listening to build your history!'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _plays.length,
                        itemBuilder: (context, index) {
                          final play = _plays[index];
                          final dateStr = play.playedAt != null
                              ? DateFormat('MMM d, yyyy • HH:mm').format(play.playedAt!.toLocal())
                              : 'Unknown date';

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.play_arrow),
                              ),
                              title: Text(
                                play.title ?? 'Unknown Title',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(play.artist ?? 'Unknown Artist'),
                                  const SizedBox(height: 4),
                                  Text(
                                    dateStr,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey[500],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
