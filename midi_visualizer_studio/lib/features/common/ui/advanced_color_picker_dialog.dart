import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:midi_visualizer_studio/features/common/services/color_history_service.dart';

class AdvancedColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const AdvancedColorPickerDialog({super.key, required this.initialColor});

  @override
  State<AdvancedColorPickerDialog> createState() => _AdvancedColorPickerDialogState();
}

class _AdvancedColorPickerDialogState extends State<AdvancedColorPickerDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Color _currentColor;
  late double _currentAlpha;
  List<Color> _history = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentColor = widget.initialColor.withAlpha(255); // Opaque color for picker
    _currentAlpha = widget.initialColor.a * 255;
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = context.read<ColorHistoryService>().getHistory();
    setState(() {
      _history = history;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onColorChanged(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  void _onAlphaChanged(double value) {
    setState(() {
      _currentAlpha = value;
    });
  }

  Color get _finalColor => _currentColor.withAlpha(_currentAlpha.toInt());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Color'),
      content: SizedBox(
        width: 400,
        height: 450,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Presets'),
                Tab(text: 'History'),
                Tab(text: 'Custom'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildPresetsTab(), _buildHistoryTab(), _buildCustomTab()],
              ),
            ),
            const Divider(),
            _buildAlphaSlider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _finalColor,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  '#${_finalColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            // Add to history if it's a custom color (not strictly checking if it's in presets,
            // but adding the final selected color to history is good UX)
            context.read<ColorHistoryService>().addToHistory(_finalColor);
            Navigator.of(context).pop(_finalColor);
          },
          child: const Text('Select'),
        ),
      ],
    );
  }

  Widget _buildPresetsTab() {
    final List<Color> presets = [
      ...Colors.primaries,
      ...Colors.accents,
      Colors.grey,
      Colors.black,
      Colors.white,
      Colors.transparent,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(spacing: 8, runSpacing: 8, children: presets.map((color) => _buildColorItem(color)).toList()),
    );
  }

  Widget _buildHistoryTab() {
    if (_history.isEmpty) {
      return const Center(child: Text('No history yet'));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Wrap(spacing: 8, runSpacing: 8, children: _history.map((color) => _buildColorItem(color)).toList()),
    );
  }

  Widget _buildCustomTab() {
    return SingleChildScrollView(
      child: ColorPicker(
        pickerColor: _currentColor,
        onColorChanged: _onColorChanged,
        enableAlpha: false, // We handle alpha separately
        displayThumbColor: true,
        pickerAreaHeightPercent: 0.7,
        portraitOnly: true, // Force vertical layout
        labelTypes: const [], // Hide default labels to save space
      ),
    );
  }

  void _onPaletteColorSelected(Color color) {
    setState(() {
      _currentColor = color;
      _currentAlpha = color.a * 255;
    });
  }

  Widget _buildColorItem(Color color) {
    // Compare value including alpha for history items, but for presets we might want to be looser?
    // Actually, _currentColor stores the RGB part (with 255 alpha usually from picker) and _currentAlpha stores alpha.
    // So to check "is selected", we should compare _finalColor.
    final isSelected = color.value == _finalColor.value;

    return GestureDetector(
      onTap: () => _onPaletteColorSelected(color),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          border: isSelected
              ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3)
              : Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildAlphaSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Opacity: ${(_currentAlpha / 255 * 100).toInt()}%'),
        Slider(
          value: _currentAlpha,
          min: 0,
          max: 255,
          divisions: 51, // 255 / 5 = 51 steps (0, 5, 10... 255)
          label: _currentAlpha.toInt().toString(),
          onChanged: _onAlphaChanged,
        ),
      ],
    );
  }
}
