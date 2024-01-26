import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/di/di.dart';
import 'package:hotel/src/domain/models/tourist_form_state.dart';
import 'package:hotel/src/presentation/blocs/reservation/reservation_bloc.dart';
import 'package:hotel/src/presentation/screens/pay_success_screen.dart';
import 'package:hotel/src/presentation/widgets/app_textfield.dart';
import 'package:hotel/src/presentation/widgets/custom_app_bar.dart';
import 'package:hotel/src/presentation/widgets/custom_bottom_bar.dart';
import 'package:hotel/src/presentation/widgets/hotel_rating.dart';
import 'package:hotel/src/presentation/widgets/section.dart';
import 'package:hotel/src/presentation/widgets/tourist_form.dart';

class ReservationScreen extends StatelessWidget {
  static const routeName = '/reservation';

  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationBloc>(
      create: (_) => getIt<ReservationBloc>(),
      child: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          final ReservationBloc reservationBloc = context.read<ReservationBloc>();
          if (state is ToursLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is ToursFailure) {
            return Center(child: Text('Failed to load tours: ${state.message}'));
          }
          if (state is ToursLoaded) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: const CustomAppBar(
                title: 'Бронирование',
                showLeading: true,
              ),
              bottomNavigationBar: CustomBottomBar(
                  buttonLabel: 'Оплатить ${state.tours[0].totalPrice} ₽',
                  onTap: () {
                    reservationBloc.add(ValidateInput());

                    if (state.isValid == true) {
                      Navigator.pushNamed(
                        context,
                        PaySuccessScreen.routeName,
                      );
                    }
                  }),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Section(
                      children: [
                        HotelRating(
                          rating: state.tours[0].rating?.toInt(),
                          ratingName: state.tours[0].ratingName,
                        ),
                        const SizedBox(height: 8),
                        Text(state.tours[0].hotelName, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          state.tours[0].hotelAdress,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.blueText),
                        ),
                      ],
                    ),
                    Section(children: [
                      tourInfoItem(context, 'Вылет из', state.tours[0].departure),
                      tourInfoItem(context, 'Страна, город', state.tours[0].arrival),
                      tourInfoItem(
                          context, 'Даты', '${state.tours[0].dateOfDeparture} - ${state.tours[0].dateOfArrival}'),
                      tourInfoItem(context, 'Кол-во ночей', state.tours[0].numberOfNights.toString()),
                      tourInfoItem(context, 'Отель', state.tours[0].hotelName),
                      tourInfoItem(context, 'Номер', state.tours[0].room),
                      tourInfoItem(context, 'Питание', state.tours[0].nutrition),
                    ]),
                    Section(children: [
                      _customerInfo(context),
                      const SizedBox(height: 20),
                      _phoneNumberTextfield(state, reservationBloc),
                      const SizedBox(height: 8),
                      _emailTextField(state, reservationBloc),
                      const SizedBox(height: 8),
                      _userDataSafetyInfo(context),
                    ]),
                    Column(
                      children: state.tourists.keys
                          .map((tourist) => TouristForm(
                                formState: state.tourists[tourist] ?? TouristFormState.create(isOpen: true),
                                tourist: tourist,
                                isOpen: state.tourists[tourist]?.isOpen ?? false,
                                onTap: () => reservationBloc.add(ChangeTouristFormVisibility(tourist: tourist)),
                                reservationBloc: reservationBloc,
                              ))
                          .toList(),
                    ),
                    Section(children: [
                      Row(
                        children: [
                          Text(
                            'Добавить туриста',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              reservationBloc.add(AddTourist());
                            },
                            child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.blueButton,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 18,
                                )),
                          )
                        ],
                      )
                    ]),
                    Section(children: [
                      priceItem(context, 'Тур', state.tours[0].price),
                      priceItem(context, 'Топливный сбор', state.tours[0].fuelCharge),
                      priceItem(context, 'Сервисный сбор', state.tours[0].serviceCharge),
                      priceItem(context, 'К оплате', state.tours[0].totalPrice),
                    ])
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

  AppTextField _emailTextField(ToursLoaded state, ReservationBloc reservationBloc) {
    return AppTextField(
      label: 'Почта',
      controller: state.emailController,
      isValid: state.isMailValid,
      isModified: state.isMailModified,
      onEditingComplete: () => reservationBloc.add(ValidateMail()),
    );
  }

  AppTextField _phoneNumberTextfield(ToursLoaded state, ReservationBloc reservationBloc) {
    return AppTextField(
      label: 'Номер телефона',
      controller: state.phoneNumberController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
      ],
      keyboardType: TextInputType.number,
      isValid: state.isPhoneNumberValid,
      isModified: state.isPhoneNumberModified,
      onChanged: (_) => reservationBloc..add(PhoneNumberInput()),
      onEditingComplete: () => reservationBloc..add(ValidatePhoneNumber()),
    );
  }

  Text _userDataSafetyInfo(BuildContext context) {
    return Text('Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyText));
  }

  Text _customerInfo(BuildContext context) {
    return Text(
      'Информация о покупателе',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget tourInfoItem(BuildContext context, String item, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(children: [
        SizedBox(
          width: 140,
          child: Text(
            item,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.greyText),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 172,
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ]),
    );
  }

  Widget priceItem(BuildContext context, String priceFor, num? price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(children: [
        Text(
          priceFor,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.greyText),
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Text(
          '$price ₽',
          style: Theme.of(context).textTheme.labelMedium,
        )
      ]),
    );
  }
}
