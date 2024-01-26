import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/di/di.dart';
import 'package:hotel/src/presentation/blocs/hotel/hotel_bloc.dart';
import 'package:hotel/src/presentation/screens/room_selection_screen.dart';
import 'package:hotel/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hotel/src/presentation/widgets/custom_bottom_bar.dart';
import 'package:hotel/src/presentation/widgets/hotel_rating.dart';
import 'package:hotel/src/presentation/widgets/peculiarities_widget.dart';
import 'package:hotel/src/presentation/widgets/section.dart';

class HotelScreen extends StatelessWidget {
  static const routeName = '/hotel';

  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HotelBloc>(
      create: (_) => getIt<HotelBloc>()..add(LoadHotels()),
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (_, state) {
          if (state is HotelsLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is HotelsFailure) {
            return Center(child: Text('Failed to load hotels: ${state.message}'));
          }
          if (state is HotelsLoaded) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: const CustomAppBar(
                title: 'Отель',
                showLeading: false,
              ),
              bottomNavigationBar: CustomBottomBar(
                buttonLabel: 'К выбору номера',
                onTap: () => Navigator.pushNamed(
                  context,
                  RoomSelectionScreen.routeName,
                  arguments: state.hotels[0],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _hotelHeader(state, context),
                    const SizedBox(height: 8),
                    _aboutHotel(context, state),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Container _hotelHeader(HotelsLoaded state, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _carousel(state),
            const SizedBox(height: 16),
            _hotelRating(state),
            const SizedBox(height: 8),
            _hotelName(state, context),
            const SizedBox(height: 8),
            _hotelAdress(state, context),
            const SizedBox(height: 16),
            _price(state, context)
          ],
        ),
      ),
    );
  }

  Section _aboutHotel(BuildContext context, HotelsLoaded state) {
    return Section(
      children: [
        Text('Об отеле', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        PeculiaritiesWidget(peculiarities: state.hotels[0].hotelDetails?.peculiarities ?? []),
        const SizedBox(height: 12),
        Text(state.hotels[0].hotelDetails?.description ?? '', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.extraLightGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _aboutHotelItem(context, iconPath: 'assets/icons/emoji_happy.svg', label: 'Удобства'),
                  _aboutHotelDivider(),
                  _aboutHotelItem(context, iconPath: 'assets/icons/tick_square.svg', label: 'Что включено'),
                  _aboutHotelDivider(),
                  _aboutHotelItem(context, iconPath: 'assets/icons/close_square.svg', label: 'Что не включено'),
                ],
              ),
            ))
      ],
    );
  }

  Padding _aboutHotelDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 40),
      child: Divider(
        height: 20,
      ),
    );
  }

  Row _aboutHotelItem(BuildContext context, {required String iconPath, required String label}) {
    return Row(
      children: [
        _hotelIcon(iconPath),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Самое необходимое',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.greyText,
                  ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.chevron_right, color: Colors.black, size: 24),
      ],
    );
  }

  SvgPicture _hotelIcon(String path) {
    return SvgPicture.asset(
      path,
      width: 24,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
    );
  }

  Row _price(HotelsLoaded state, BuildContext context) {
    return Row(
      children: [
        Text('От ${state.hotels[0].minimalPrice?.toInt()} ₽', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(width: 8),
        Text('${state.hotels[0].priceFor}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.greyText)),
      ],
    );
  }

  Text _hotelAdress(HotelsLoaded state, BuildContext context) {
    return Text(state.hotels[0].adress,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.blueText));
  }

  Text _hotelName(HotelsLoaded state, BuildContext context) =>
      Text(state.hotels[0].name, style: Theme.of(context).textTheme.titleMedium);

  HotelRating _hotelRating(HotelsLoaded state) {
    return HotelRating(rating: state.hotels[0].rating?.toInt(), ratingName: state.hotels[0].ratingName);
  }

  FlutterCarousel _carousel(HotelsLoaded state) {
    return FlutterCarousel(
      items: state.hotels[0].imageUrls
          .map((url) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    url,
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
    );
  }
}
