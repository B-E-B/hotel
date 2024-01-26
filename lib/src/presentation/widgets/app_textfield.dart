import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel/src/common/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isValid;
  final bool isModified;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String label;
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isValid = true,
    this.isModified = false,
    this.inputFormatters = const [],
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: isValid || !isModified ? AppColors.extraLightGrey : AppColors.error,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.greyText),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
