import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import '../auth/auth_provider.dart';
import '../utils/error_utils.dart';

class VinylDetailScreen extends StatefulWidget {
  final VinylSearchResult? searchResult;
  final VinylRecord? vinylRecord;

  const VinylDetailScreen({
    super.key,
    this.searchResult,
    this.vinylRecord,
  }) : assert(searchResult != null || vinylRecord != null);

  @override
  State<VinylDetailScreen> createState() => _VinylDetailScreenState();
}

class _VinylDetailScreenState extends State<VinylDetailScreen> {
  bool _isAdding = false;
  bool _isPlaying = false;
  late VinylApi _vinylApi;

  @override
  void initState() {
    super.initState();
    _vinylApi = VinylApi(context.read<AuthProvider>().apiClient);
  }

  String get _title => widget.searchResult?.title ?? widget.vinylRecord!.title;
  String get _artist => widget.searchResult?.artist ?? widget.vinylRecord!.artist;
  String? get _coverImage => widget.searchResult?.coverImage ?? widget.vinylRecord?.coverImage;
  int? get _year => widget.searchResult?.year ?? widget.vinylRecord?.year;
  List<String> get _genres => widget.searchResult?.genres ?? widget.vinylRecord?.genres ?? [];
  List<String> get _styles => widget.searchResult?.styles ?? widget.vinylRecord?.styles ?? [];

  Future<void> _addToCollection() async {
    setState(() {
      _isAdding = true;
    });

    try {
      final payload = VinylPayload(
        discogsId: widget.searchResult!.discogsId,
      );

      await _vinylApi.postVinylRoute(payload: payload);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to collection!')),
        );
        Navigator.pop(context, true); // Return true to signal refresh
      }
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Failed to add: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAdding = false;
        });
      }
    }
  }

  Future<void> _registerPlay() async {
    setState(() {
      _isPlaying = true;
    });

    try {
      final payload = PlayPayload(
        artist: _artist,
        title: _title,
      );

      await _vinylApi.postPlayRoute(payload: payload);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Play registered!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Failed to register play: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_coverImage != null)
              Image.network(
                _coverImage!,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.album, size: 100, color: Colors.grey),
                ),
              )
            else
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[200],
                child: const Icon(Icons.album, size: 100, color: Colors.grey),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _artist,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                  if (_year != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Year: $_year',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                  if (_genres.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Genres',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _genres
                          .map((g) => Chip(label: Text(g)))
                          .toList(),
                    ),
                  ],
                  if (_styles.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Styles',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _styles
                          .map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: widget.searchResult != null
                        ? ElevatedButton.icon(
                            onPressed: _isAdding ? null : _addToCollection,
                            icon: _isAdding
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.add),
                            label: const Text('Add to Collection'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: _isPlaying ? null : _registerPlay,
                            icon: _isPlaying
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.play_arrow),
                            label: const Text('Register Play'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
