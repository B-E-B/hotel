import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;

  const AppButton({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.blueButton),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
