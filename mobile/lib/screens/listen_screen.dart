import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import '../auth/auth_provider.dart';
import '../services/recognition_provider.dart';
import '../utils/error_utils.dart';

class ListenScreen extends StatefulWidget {
  const ListenScreen({super.key});

  @override
  State<ListenScreen> createState() => _ListenScreenState();
}

class _ListenScreenState extends State<ListenScreen> {
  late VinylApi _vinylApi;
  List<VinylRecord> _vinyls = [];
  List<VinylRecord> _filteredVinyls = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  
  StreamSubscription? _recognitionSubscription;
  RecognitionResult? _lastTrack;
  bool _isAutoMode = false;

  @override
  void initState() {
    super.initState();
    _vinylApi = VinylApi(context.read<AuthProvider>().apiClient);
    _fetchVinyls();
    _setupRecognition();
  }

  @override
  void dispose() {
    _recognitionSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _setupRecognition() {
    // Note: Instead of a stream, we can use Provider's notifyListeners
    // or we could add a stream to RecognitionProvider if needed.
    // For now, we'll rely on build() and context.watch() for UI updates.
  }

  Future<void> _fetchVinyls() async {
    setState(() => _isLoading = true);
    try {
      final vinyls = await _vinylApi.getVinylsRoute();
      setState(() {
        _vinyls = vinyls ?? [];
        _filteredVinyls = _vinyls;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Failed to load collection: $e');
      }
      setState(() => _isLoading = false);
    }
  }

  void _filterVinyls(String query) {
    setState(() {
      _filteredVinyls = _vinyls
          .where((v) =>
              v.title.toLowerCase().contains(query.toLowerCase()) ||
              v.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _registerPlayRaw(String artist, String title) async {
    try {
      final payload = PlayPayload(artist: artist, title: title);
      await _vinylApi.postPlayRoute(payload: payload);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Recorded play for $title by $artist'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.teal[700],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Auto-record failed: $e');
      }
    }
  }

  Future<void> _registerPlay(VinylRecord vinyl) async {
    await _registerPlayRaw(vinyl.artist, vinyl.title);
  }

  @override
  Widget build(BuildContext context) {
    final recognition = context.watch<RecognitionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isAutoMode ? Icons.auto_awesome : Icons.auto_awesome_outlined),
            color: _isAutoMode ? Colors.teal : null,
            onPressed: () async {
              final recognition = context.read<RecognitionProvider>();
              if (!_isAutoMode) {
                await recognition.startListening();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Auto-Recognition Enabled')),
                  );
                }
              } else {
                await recognition.stopListening();
              }
              
              if (mounted) {
                setState(() {
                  _isAutoMode = !_isAutoMode;
                });
              }
            },
            tooltip: 'Toggle Auto-Recognition',
          ),
        ],
      ),
      body: Column(
        children: [
          // Recognition Status Card
          _buildRecognitionCard(recognition),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterVinyls,
              decoration: InputDecoration(
                hintText: 'Search your collection...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text('Tap a record to record a manual play session.', 
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredVinyls.isEmpty
                    ? const Center(child: Text('No matching records found.'))
                    : ListView.builder(
                        itemCount: _filteredVinyls.length,
                        itemBuilder: (context, index) {
                          final vinyl = _filteredVinyls[index];
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: vinyl.thumbImage != null
                                  ? Image.network(vinyl.thumbImage!, width: 40, height: 40, fit: BoxFit.cover)
                                  : const Icon(Icons.album),
                            ),
                            title: Text(vinyl.title),
                            subtitle: Text(vinyl.artist),
                            trailing: const Icon(Icons.play_arrow, color: Colors.teal),
                            onTap: () => _registerPlay(vinyl),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: recognition.toggleListening,
        backgroundColor: recognition.isListening ? Colors.red.shade800 : Colors.teal,
        foregroundColor: Colors.white,
        icon: Icon(recognition.isListening ? Icons.stop : Icons.mic),
        label: Text(recognition.isListening ? 'Stop Listening' : 'Start Listening'),
      ),
    );
  }

  Widget _buildRecognitionCard(RecognitionProvider recognition) {
    if (!recognition.isListening && recognition.lastResult == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  recognition.isRecording ? Icons.radio_button_checked : Icons.mic,
                  color: recognition.isRecording ? Colors.red : Colors.teal,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  recognition.isRecording ? 'Listening for music...' : 'Active Listener',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: recognition.isRecording ? Colors.red : Colors.teal,
                  ),
                ),
                const Spacer(),
                if (recognition.lastResult != null)
                  Text(
                    (recognition.lastResult!.success ?? false) ? 'Matched' : 'No Match',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            if (recognition.lastResult != null && (recognition.lastResult!.success ?? false)) ...[
              const Divider(height: 24),
              Row(
                children: [
                  if (recognition.lastResult!.coverArt != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        recognition.lastResult!.coverArt!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Icon(Icons.music_note, size: 60),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recognition.lastResult!.title ?? 'Unknown Title',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          recognition.lastResult!.artist ?? 'Unknown Artist',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
                    tooltip: 'Register Play',
                    onPressed: () {
                      // Call play registration with recognized info
                      _registerPlayForRecognized(recognition.lastResult!);
                    },
                  ),
                ],
              ),
            ] else if (recognition.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  recognition.error!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerPlayForRecognized(RecognitionResult result) async {
     try {
      final payload = PlayPayload(artist: result.artist ?? 'Unknown', title: result.title ?? 'Unknown');
      await _vinylApi.postPlayRoute(payload: payload);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recorded play for ${result.title}!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Failed to record play: $e');
      }
    }
  }
}
