import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:midi_visualizer_studio/data/repositories/project_repository.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int _rows = 4;
  int _cols = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutorial')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Your First Layout',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Define the grid size for your controller.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Preview
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[200],
                      ),
                      child: CustomPaint(
                        painter: _GridPreviewPainter(rows: _rows, cols: _cols),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControl('Rows', _rows, (val) => setState(() => _rows = val)),
                  _buildControl('Columns', _cols, (val) => setState(() => _cols = val)),
                ],
              ),

              const SizedBox(height: 32),

              // Action
              ElevatedButton(
                onPressed: _createProject,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Create Project'),
              ),
              const SizedBox(height: 16),
              TextButton(onPressed: () => context.go('/home'), child: const Text('Skip Tutorial')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControl(String label, int value, ValueChanged<int> onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: value > 1 ? () => onChanged(value - 1) : null,
            ),
            Text('$value', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: value < 16 ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }

  void _createProject() {
    final projectRepository = context.read<ProjectRepository>();
    final project = projectRepository.createProject(rows: _rows, cols: _cols);

    context.go('/editor/${project.id}', extra: project);
  }
}

class _GridPreviewPainter extends CustomPainter {
  final int rows;
  final int cols;

  _GridPreviewPainter({required this.rows, required this.cols});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final cellWidth = size.width / cols;
    final cellHeight = size.height / rows;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final rect = Rect.fromLTWH(i * cellWidth + 4, j * cellHeight + 4, cellWidth - 8, cellHeight - 8);
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPreviewPainter oldDelegate) {
    return oldDelegate.rows != rows || oldDelegate.cols != cols;
  }
}
