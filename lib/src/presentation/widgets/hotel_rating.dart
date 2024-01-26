import 'package:flutter/material.dart';
import 'package:hotel/src/common/theme/app_colors.dart';

class HotelRating extends StatelessWidget {
  final int? rating;
  final String? ratingName;

  const HotelRating({
    super.key,
    required this.rating,
    required this.ratingName,
  });

  @override
  Widget build(BuildContext context) {
    return rating != null && ratingName != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.lightYellow,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: AppColors.yellow, size: 18),
                  Text('$rating $ratingName',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.yellow)),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
