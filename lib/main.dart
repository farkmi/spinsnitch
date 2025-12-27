import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinsnitch_api/api.dart'; // Import the generated API client
import 'auth/auth_provider.dart';
import 'screens/login_screen.dart';
import 'config.dart';
import 'utils/error_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(apiBaseUrl: AppConfig.apiBaseUrl)),
      ],
      child: MaterialApp(
        title: 'SpinSnitch',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    
    if (auth.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (auth.isAuthenticated) {
      return const VinylListScreen(title: 'SpinSnitch Vinyls');
    } else {
      return const LoginScreen();
    }
  }
}

class VinylListScreen extends StatefulWidget {
  const VinylListScreen({super.key, required this.title});

  final String title;

  @override
  State<VinylListScreen> createState() => _VinylListScreenState();
}

class _VinylListScreenState extends State<VinylListScreen> {
  // Use the authenticated client from the provider
  late VinylApi _vinylApi;
  List<VinylRecord> _vinyls = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Do not initialize API Client here, get it from Provider.
    // However, can't access context in initState directly for Provider if listen=true.
    // We can fetch data in didChangeDependencies or addPostFrameCallback.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApiAndFetch();
    });
  }

  void _initApiAndFetch() {
    final authProvider = context.read<AuthProvider>();
    _vinylApi = VinylApi(authProvider.apiClient);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchVinyls,
                        child: const Text('Retry'),
                      )
                    ],
                  )
                : _vinyls.isEmpty
                    ? const Text('No vinyls found.')
                    : ListView.builder(
                        itemCount: _vinyls.length,
                        itemBuilder: (context, index) {
                          final vinyl = _vinyls[index];
                          return ListTile(
                            leading: vinyl.thumbImage != null
                                ? Image.network(vinyl.thumbImage!)
                                : const Icon(Icons.album),
                             title: Text(vinyl.title),
                            subtitle: Text(vinyl.artist),
                          );
                        },
                      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchVinyls,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
