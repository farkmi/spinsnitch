import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart';
import '../auth/auth_provider.dart';
import '../utils/error_utils.dart';
import 'vinyl_detail_screen.dart';
import 'barcode_scanner_screen.dart';

class VinylSearchScreen extends StatefulWidget {
  const VinylSearchScreen({super.key});

  @override
  State<VinylSearchScreen> createState() => _VinylSearchScreenState();
}

class _VinylSearchScreenState extends State<VinylSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<VinylSearchResult> _searchResults = [];
  bool _isLoading = false;
  late VinylApi _vinylApi;

  @override
  void initState() {
    super.initState();
    _vinylApi = VinylApi(context.read<AuthProvider>().apiClient);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.length > 2) {
        _performSearch(query);
      } else if (query.isEmpty) {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _vinylApi.getVinylSearchRoute(query);
      setState(() {
        _searchResults = results ?? [];
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ErrorUtils.showErrorSnackBar(context, 'Search failed: ${e.toString()}');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _scanBarcode() async {
    final barcode = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const BarcodeScannerScreen(),
      ),
    );

    if (barcode != null && mounted) {
      _searchController.text = barcode;
      _performSearch(barcode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Vinyls'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search artist, title or barcode...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: _scanBarcode,
                      ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        _searchController.text.length > 2
                            ? 'No results found.'
                            : 'Start typing to search...',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return ListTile(
                          leading: result.thumbImage != null
                              ? Image.network(
                                  result.thumbImage!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.album),
                                )
                              : const Icon(Icons.album),
                          title: Text(result.title),
                          subtitle: Text(result.artist),
                          onTap: () {
                            final navigator = Navigator.of(context);
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) => VinylDetailScreen(
                                  searchResult: result,
                                ),
                              ),
                            ).then((value) {
                              if (value == true && mounted) {
                                navigator.pop(true);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}
