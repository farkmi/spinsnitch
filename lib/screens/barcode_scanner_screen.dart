import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isFinished = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Vinyl Barcode'),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              if (_isFinished) return;
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  setState(() {
                    _isFinished = true;
                  });
                  Navigator.of(context).pop(barcode.rawValue);
                  break;
                }
              }
            },
          ),
          _buildOverlay(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Align barcode within the frame',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
