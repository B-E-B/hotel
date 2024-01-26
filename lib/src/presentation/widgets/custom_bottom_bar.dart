import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/presentation/widgets/app_button.dart';

class CustomBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final String buttonLabel;
  final void Function()? onTap;

  const CustomBottomBar({
    Key? key,
    required this.buttonLabel,
    required this.onTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.white,
      child: AppButton(onTap: onTap, label: buttonLabel),
    );
  }
}
