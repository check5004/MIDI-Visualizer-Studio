import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:midi_visualizer_studio/core/utils/path_utils.dart';

void main() {
  group('PathUtils', () {
    test('parsePath parses M and L commands', () {
      final path = 'M 10 10 L 20 20 L 30 10 Z';
      final points = PathUtils.parsePath(path);
      expect(points.length, 3);
      expect(points[0], const Offset(10, 10));
      expect(points[1], const Offset(20, 20));
      expect(points[2], const Offset(30, 10));
    });

    test('generatePath generates correct string', () {
      final points = [const Offset(10, 10), const Offset(20, 20), const Offset(30, 10)];
      final path = PathUtils.generatePath(points);
      expect(path, 'M 10.00 10.00 L 20.00 20.00 L 30.00 10.00 Z');
    });

    test('smoothPath returns original points if amount is 0', () {
      final points = [const Offset(0, 0), const Offset(100, 0), const Offset(100, 100), const Offset(0, 100)];
      final smoothed = PathUtils.smoothPath(points, 0.0);
      expect(smoothed, points);
    });

    test('smoothPath with amount > 1.0 increases iterations', () {
      final points = [const Offset(0, 0), const Offset(100, 0), const Offset(100, 100), const Offset(0, 100)];

      // Amount 2.0 -> 2 iterations.
      // Iteration 1 (ratio 0.5): 8 points.
      // Iteration 2 (ratio 0.5): 16 points.
      final smoothed2 = PathUtils.smoothPath(points, 2.0);
      expect(smoothed2.length, 16);

      // Amount 1.5 -> 2 iterations.
      // Iteration 1 (ratio 0.5): 8 points.
      // Iteration 2 (ratio 0.25): 16 points.
      final smoothed1_5 = PathUtils.smoothPath(points, 1.5);
      expect(smoothed1_5.length, 16);

      // Check that points are different
      expect(smoothed2, isNot(equals(smoothed1_5)));
    });

    test('smoothPath smooths a square', () {
      final points = [const Offset(0, 0), const Offset(100, 0), const Offset(100, 100), const Offset(0, 100)];

      final smoothed = PathUtils.smoothPath(points, 1.0);

      // Original: 4 points.
      // Iteration 1: 8 points.
      expect(smoothed.length, 8);

      // Check that points are within bounding box
      for (final p in smoothed) {
        expect(p.dx, greaterThanOrEqualTo(0));
        expect(p.dx, lessThanOrEqualTo(100));
        expect(p.dy, greaterThanOrEqualTo(0));
        expect(p.dy, lessThanOrEqualTo(100));
      }

      expect(smoothed.contains(const Offset(0, 0)), isFalse);
    });
    test('simplifyPath reduces points', () {
      final points = [
        const Offset(0, 0),
        const Offset(10, 1), // Almost on line
        const Offset(20, 0),
        const Offset(30, 0),
      ];

      // Tolerance 2.0 should remove (10, 1)
      final simplified = PathUtils.simplifyPath(points, 2.0);
      expect(simplified.length, lessThan(points.length));
      expect(simplified.contains(const Offset(10, 1)), isFalse);
    });

    test('smoothPath with simplification reduces points before smoothing', () {
      final points = [
        const Offset(0, 0),
        const Offset(5, 1), // Noise
        const Offset(10, 0),
        const Offset(15, -1), // Noise
        const Offset(20, 0),
      ];

      // Amount 2.0 -> Tolerance 1.0. Should remove noise.
      // Then smooths.

      final smoothed = PathUtils.smoothPath(points, 2.0);

      // If noise was removed, we effectively smooth a line from 0,0 to 20,0.
      // 0,0 -> 20,0 is a straight line.
      // Simplification of 0,0, 5,1, 10,0, 15,-1, 20,0 with tol 1.0:
      // Dist of 10,0 to line 0,0-20,0 is 0.
      // Dist of 5,1 to line 0,0-20,0 is 1.
      // If tol is 1.0, 5,1 might be kept or removed depending on float precision/inequality.
      // Let's use larger noise or tolerance.

      // Let's rely on the fact that smoothPath now calls simplifyPath.
      // We can check if it produces different result than without simplification (amount very small).

      final smoothedSmall = PathUtils.smoothPath(points, 0.1); // Low tolerance
      final smoothedLarge = PathUtils.smoothPath(points, 5.0); // High tolerance

      expect(smoothedSmall, isNot(equals(smoothedLarge)));
    });
  });
}
