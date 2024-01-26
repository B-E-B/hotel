import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel/src/common/theme/app_colors.dart';
import 'package:hotel/src/domain/models/tourist.dart';
import 'package:hotel/src/domain/models/tourist_form_state.dart';
import 'package:hotel/src/presentation/blocs/reservation/reservation_bloc.dart';
import 'package:hotel/src/presentation/widgets/app_textfield.dart';
import 'package:hotel/src/presentation/widgets/section.dart';

class TouristForm extends StatelessWidget {
  final Tourist tourist;
  final TouristFormState formState;
  final void Function()? onTap;
  final ReservationBloc reservationBloc;
  final Map<int, String> touristNumber = {
    1: 'Первый',
    2: 'Второй',
    3: 'Третий',
    4: 'Четвертый',
    5: 'Пятый',
    6: 'Шестой',
    7: 'Седьмой',
    8: 'Восьмой',
    9: 'Девятый',
    10: 'Десятый',
    11: 'Одиннадцатый',
    12: 'Двенадцатый',
    13: 'Тринадцатый',
    14: 'Четырнадцатый',
    15: 'Пятнадцатый',
    16: 'Шестнадцатый',
    17: 'Семнадцатый',
    18: 'Восемнадцатый',
    19: 'Девятнадцатый',
    20: 'Двадцатый',
    21: 'Двадцать первый',
  };
  bool isOpen;

  TouristForm({
    super.key,
    this.isOpen = true,
    required this.tourist,
    required this.formState,
    required this.onTap,
    required this.reservationBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Section(children: [
      _touristFormHeader(context),
      Builder(builder: (BuildContext context) {
        return isOpen
            ? Column(children: [
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Имя',
                  isValid: formState.isNameValid,
                  controller: formState.nameController.controller,
                  isModified: formState.nameController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.nameController,
                  )),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Фамилия',
                  isValid: formState.isSurNameValid,
                  controller: formState.surNameController.controller,
                  isModified: formState.surNameController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.surNameController,
                  )),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Дата рождения',
                  isValid: formState.isBirthDateValid,
                  controller: formState.birthDateController.controller,
                  isModified: formState.birthDateController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.birthDateController,
                  )),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Гражданство',
                  isValid: formState.isCitizenshipValid,
                  controller: formState.citizenshipController.controller,
                  isModified: formState.citizenshipController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.citizenshipController,
                  )),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Номер загранпаспорта',
                  isValid: formState.isPassportNumberValid,
                  controller: formState.passportNumberController.controller,
                  isModified: formState.passportNumberController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.passportNumberController,
                  )),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  label: 'Срок действия загранпаспорта',
                  isValid: formState.isPassportExpDateValid,
                  controller: formState.passportExpDateController.controller,
                  isModified: formState.passportExpDateController.isModified,
                  onEditingComplete: () => reservationBloc.add(ChangeModifyStatus(
                    tourist: tourist,
                    controller: formState.passportExpDateController,
                  )),
                ),
                const SizedBox(height: 8),
              ])
            : const SizedBox.shrink();
      })
    ]);
  }

  Widget _touristFormHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          '${touristNumber[tourist.id] ?? 'и Т.Д.'} турист',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: SvgPicture.asset(
                  isOpen ? 'assets/icons/shevron_up.svg' : 'assets/icons/shevron_down.svg',
                  width: 8,
                  height: 8,
                ),
              )),
        ),
      ],
    );
  }
}
