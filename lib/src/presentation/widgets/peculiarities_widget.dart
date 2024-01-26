import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';

class PeculiaritiesWidget extends StatelessWidget {
  final List<dynamic> peculiarities;

  const PeculiaritiesWidget({
    super.key,
    required this.peculiarities,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: peculiarities
            .map(
              (peculiarity) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.extraLightGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    peculiarity,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.greyText),
                  ),
                ),
              ),
            )
            .toList());
  }
}
