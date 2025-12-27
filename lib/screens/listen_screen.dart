import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import '../auth/auth_provider.dart';
import '../services/recognition_service.dart';
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
  RecognizedTrack? _lastTrack;
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
    final recognitionService = context.read<RecognitionService>();
    
    _recognitionSubscription = recognitionService.trackStream.listen((track) {
      if (mounted) {
        setState(() {
          _lastTrack = track;
        });
        if (_isAutoMode) {
          _registerPlayRaw(track.artist, track.title);
        }
      }
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isAutoMode ? Icons.auto_awesome : Icons.auto_awesome_outlined),
            color: _isAutoMode ? Colors.teal : null,
            onPressed: () async {
              final recognitionService = context.read<RecognitionService>();
              if (!_isAutoMode) {
                final hasPermission = await recognitionService.hasPermission();
                if (!hasPermission) {
                  await recognitionService.openPermissionSettings();
                  return;
                }
                recognitionService.startListening();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Auto-Recognition Enabled')),
                  );
                }
              } else {
                recognitionService.stopListening();
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
          if (_lastTrack != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                color: Colors.teal.withAlpha(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.teal, width: 0.5),
                ),
                child: ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.teal),
                  title: const Text('Last Recognized (System)'),
                  subtitle: Text('${_lastTrack!.title} • ${_lastTrack!.artist}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => _registerPlayRaw(_lastTrack!.artist, _lastTrack!.title),
                    tooltip: 'Record this play',
                  ),
                ),
              ),
            ),
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
    );
  }
}
