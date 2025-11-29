import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String label;
  final double value;
  final double step;
  final double? min;
  final double? max;
  final bool enabled;
  final ValueChanged<double> onChanged;

  const NumberInput({
    super.key,
    required this.label,
    required this.value,
    this.step = 1.0,
    this.min,
    this.max,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // Only update text if the value is different and not currently being edited
      // to avoid cursor jumping or overwriting user input while typing.
      // However, for this simple implementation, we'll just update it if it doesn't match
      // the parsed value of the text, or if we want to force sync.
      // To keep it simple and robust for external updates (like undo/redo), we update.
      // But we check if the text parses to the new value to avoid formatting changes while typing.
      final currentTextVal = double.tryParse(_controller.text);
      if (currentTextVal != widget.value) {
        _controller.text = _formatValue(widget.value);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void _updateValue(double newValue) {
    if (widget.min != null && newValue < widget.min!) return;
    if (widget.max != null && newValue > widget.max!) return;

    widget.onChanged(newValue);
  }

  void _increment() {
    _updateValue(widget.value + widget.step);
  }

  void _decrement() {
    _updateValue(widget.value - widget.step);
  }

  void _onSubmitted(String val) {
    final num = double.tryParse(val);
    if (num != null) {
      _updateValue(num);
    } else {
      // Revert to current valid value
      _controller.text = _formatValue(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Row(
          children: [
            _StepButton(icon: Icons.remove, onPressed: widget.enabled ? _decrement : null),
            Expanded(
              child: TextFormField(
                controller: _controller,
                enabled: widget.enabled,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]'))],
                onFieldSubmitted: _onSubmitted,
                onTapOutside: (_) {
                  _onSubmitted(_controller.text);
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            _StepButton(icon: Icons.add, onPressed: widget.enabled ? _increment : null),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _StepButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
      ),
    );
  }
}
