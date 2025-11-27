import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:midi_visualizer_studio/features/poc/bucket_fill/logic/flood_fill_service.dart';
import 'package:image/image.dart' as img;

class BucketFillScreen extends StatefulWidget {
  const BucketFillScreen({super.key});

  @override
  State<BucketFillScreen> createState() => _BucketFillScreenState();
}

class _BucketFillScreenState extends State<BucketFillScreen> {
  Uint8List? _originalImageBytes;
  Uint8List? _maskImageBytes;
  bool _isProcessing = false;
  final _floodFillService = FloodFillService();

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _originalImageBytes = result.files.single.bytes;
        _maskImageBytes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bucket Fill PoC')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: _pickImage, child: const Text('Pick Image')),
          ),
          Expanded(
            child: _originalImageBytes == null
                ? const Center(child: Text('Pick an image to start'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return GestureDetector(
                        onTapDown: (details) => _handleTap(details, constraints),
                        child: Stack(
                          children: [
                            Image.memory(
                              _originalImageBytes!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            if (_maskImageBytes != null)
                              Opacity(
                                opacity: 0.5,
                                child: Image.memory(
                                  _maskImageBytes!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.red, // Tint the mask red
                                  colorBlendMode: BlendMode.srcIn,
                                ),
                              ),
                            if (_isProcessing) const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTap(TapDownDetails details, BoxConstraints constraints) async {
    if (_originalImageBytes == null || _isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      // Decode image to get dimensions
      // Note: In production, do this once and cache it.
      final image = img.decodeImage(_originalImageBytes!);
      if (image == null) return;

      final widgetWidth = constraints.maxWidth;
      final widgetHeight = constraints.maxHeight;

      final imageAspect = image.width / image.height;
      final widgetAspect = widgetWidth / widgetHeight;

      double displayedWidth, displayedHeight;
      double offsetX, offsetY;

      if (imageAspect > widgetAspect) {
        // Limited by width
        displayedWidth = widgetWidth;
        displayedHeight = widgetWidth / imageAspect;
        offsetX = 0;
        offsetY = (widgetHeight - displayedHeight) / 2;
      } else {
        // Limited by height
        displayedHeight = widgetHeight;
        displayedWidth = widgetHeight * imageAspect;
        offsetX = (widgetWidth - displayedWidth) / 2;
        offsetY = 0;
      }

      final localX = details.localPosition.dx - offsetX;
      final localY = details.localPosition.dy - offsetY;

      if (localX < 0 || localX >= displayedWidth || localY < 0 || localY >= displayedHeight) {
        // Tapped outside image
        return;
      }

      final imageX = (localX / displayedWidth * image.width).round();
      final imageY = (localY / displayedHeight * image.height).round();

      final mask = await _floodFillService.floodFill(imageBytes: _originalImageBytes!, startX: imageX, startY: imageY);

      setState(() {
        _maskImageBytes = mask;
      });
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}
