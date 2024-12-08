import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.maxLines,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final int maxLines;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: AppColors.hex181818,
      ),
      onChanged: widget.onChanged,
    );
  }
}
