import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showLeading = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: showLeading
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left),
            )
          : null,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.white,
      actions: actions,
    );
  }
}
