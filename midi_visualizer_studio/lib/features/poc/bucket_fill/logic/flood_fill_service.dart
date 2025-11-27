import 'dart:collection';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class FloodFillService {
  /// Performs a flood fill on the given image starting from (x, y).
  /// Returns a mask image where filled pixels are white (255) and others are transparent (0).
  /// [tolerance] is the color distance tolerance (0-100).
  Future<Uint8List?> floodFill({
    required Uint8List imageBytes,
    required int startX,
    required int startY,
    int tolerance = 10,
  }) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) return null;

    final width = image.width;
    final height = image.height;

    if (startX < 0 || startX >= width || startY < 0 || startY >= height) {
      return null;
    }

    // Create a mask image (initially transparent)
    final mask = img.Image(width: width, height: height, numChannels: 4);

    // Target color at start position
    final targetPixel = image.getPixel(startX, startY);
    final targetR = targetPixel.r;
    final targetG = targetPixel.g;
    final targetB = targetPixel.b;
    final targetA = targetPixel.a;

    // Visited array to prevent loops
    final visited = Uint8List(width * height); // 0: not visited, 1: visited

    final queue = Queue<({int x, int y})>();
    queue.add((x: startX, y: startY));

    // Helper to check color match
    bool colorsMatch(img.Pixel p) {
      if (p.a == 0 && targetA == 0) return true; // Both transparent

      final diff = (p.r - targetR).abs() + (p.g - targetG).abs() + (p.b - targetB).abs() + (p.a - targetA).abs();

      // Max diff is 255*4 = 1020. Tolerance is percentage.
      return diff <= (1020 * tolerance / 100);
    }

    while (queue.isNotEmpty) {
      final point = queue.removeFirst();
      final x = point.x;
      final y = point.y;

      final index = y * width + x;
      if (visited[index] == 1) continue;
      visited[index] = 1;

      // Set mask pixel to white (fully opaque)
      mask.setPixelRgba(x, y, 255, 255, 255, 255);

      // Check neighbors
      final neighbors = [(x: x + 1, y: y), (x: x - 1, y: y), (x: x, y: y + 1), (x: x, y: y - 1)];

      for (final n in neighbors) {
        if (n.x >= 0 && n.x < width && n.y >= 0 && n.y < height) {
          final nIndex = n.y * width + n.x;
          if (visited[nIndex] == 0) {
            final pixel = image.getPixel(n.x, n.y);
            if (colorsMatch(pixel)) {
              queue.add(n);
            }
          }
        }
      }
    }

    return img.encodePng(mask);
  }
}
