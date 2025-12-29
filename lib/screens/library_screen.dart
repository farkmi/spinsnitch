import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import '../auth/auth_provider.dart';
import 'vinyl_detail_screen.dart';
import '../utils/error_utils.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late VinylApi _vinylApi;
  List<VinylRecord> _vinyls = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _vinylApi = VinylApi(context.read<AuthProvider>().apiClient);
    _fetchVinyls();
  }

  Future<void> _fetchVinyls() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final vinyls = await _vinylApi.getVinylsRoute();
      setState(() {
        _vinyls = vinyls ?? [];
        _isLoading = false;
      });
    } catch (e) {
      final errorMessage = e.toString();
      setState(() {
        _error = errorMessage;
        _isLoading = false;
      });
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            title: Text('My Collection'),
            centerTitle: true,
          ),
          if (_error != null && _vinyls.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $_error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _fetchVinyls,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (_vinyls.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Your collection is empty.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(12.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final vinyl = _vinyls[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VinylDetailScreen(
                                vinylRecord: vinyl,
                              ),
                            ),
                          ).then((_) => _fetchVinyls());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: vinyl.thumbImage != null
                                    ? Image.network(
                                        vinyl.thumbImage!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.album, size: 80),
                                      )
                                    : const Icon(Icons.album, size: 80),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vinyl.title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      vinyl.artist,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[400],
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _vinyls.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
