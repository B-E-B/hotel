import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/presentation/screens/reservation_screen.dart';
import 'package:hotel/src/presentation/widgets/app_button.dart';
import 'package:hotel/src/presentation/widgets/peculiarities_widget.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlutterCarousel(
                items: room.imageUrls
                    .map((url) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              url ?? '',
                              width: 344,
                              height: 260,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 260.0,
                  showIndicator: true,
                  slideIndicator: const CircularSlideIndicator(
                    indicatorRadius: 3.5,
                    itemSpacing: 12,
                    indicatorBackgroundColor: AppColors.extraLightGrey,
                    currentIndicatorColor: AppColors.infoColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.lightYellow,
                ),
              ),
              const SizedBox(height: 8),
              Text(room.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              PeculiaritiesWidget(peculiarities: room.peculiarities),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.lightBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Подробнее о номере',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.blueText),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.blueText)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'От ${room.price.toInt()} ₽',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    room.priceFor,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.greyText),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Выбрать номер',
                onTap: () => Navigator.pushNamed(
                  context,
                  ReservationScreen.routeName,
                  arguments: room,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
