import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hotel/src/domain/models/tour.dart';
import 'package:hotel/src/domain/models/tourist.dart';
import 'package:hotel/src/domain/models/tourist_controllers.dart';
import 'package:hotel/src/domain/models/tourist_form_state.dart';
import 'package:hotel/src/domain/usecases/get_tours_usecase.dart';
import 'package:injectable/injectable.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

@injectable
class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final GetToursUsecase _getToursUsecase;

  ReservationBloc({
    required GetToursUsecase getToursUsecase,
  })  : _getToursUsecase = getToursUsecase,
        super(ToursLoading()) {
    on<LoadTours>(_onLoadTours);
    on<PhoneNumberInput>(_formatPhoneNumber);
    on<AddTourist>(_onAddTourist);
    on<ChangeTouristFormVisibility>(_changeTouristFormVisibility);
    on<ValidateInput>(_onValidateInput);
    on<ChangeModifyStatus>(_changeModifyStatus);
    on<ValidateMail>(_onValidateMail);
    on<ValidatePhoneNumber>(_onValidatePhoneNumber);
    add(LoadTours());
  }

  void _onLoadTours(LoadTours event, Emitter<ReservationState> emit) async {
    await _getToursUsecase().fold((failure) {
      emit(ToursFailure(message: failure.toString()));
    }, (tours) async {
      final loadedTours = await tours;
      emit(
        ToursLoaded(
            tours: loadedTours,
            phoneNumberController: TextEditingController(),
            emailController: TextEditingController(),
            tourists: <Tourist, TouristFormState>{const Tourist(id: 1): TouristFormState.create(isOpen: true)}),
      );
    });
  }

  void _onAddTourist(AddTourist event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      Map<Tourist, TouristFormState> tourists = (state as ToursLoaded).tourists;
      final Tourist newTourist = Tourist(id: tourists.length + 1);
      emit((state as ToursLoaded).copyWith(
        tourists: {...tourists, newTourist: TouristFormState.create(isOpen: true)},
      ));
    }
  }

  void _formatPhoneNumber(PhoneNumberInput event, Emitter<ReservationState> emit) {
    String formattedPhoneNumber = '';
    String formatted = '';
    if (state is ToursLoaded) {
      final input = (state as ToursLoaded).phoneNumberController.text;
      final bool isDeleted = (state as ToursLoaded).previousPhoneLenght > input.length;
      emit((state as ToursLoaded).copyWith(previousPhoneLenght: input.length));
      if (!isDeleted && input.length == 1) {
        formatted = '+7($input';
      } else if (!isDeleted && input.length == 6) {
        formatted = '$input)';
      } else if (!isDeleted && input.length == 10) {
        formatted = '$input-';
      } else if (!isDeleted && input.length == 13) {
        formatted = '$input-';
      } else {
        formatted = input;
      }

      formattedPhoneNumber = formatted;

      (state as ToursLoaded).phoneNumberController.value = TextEditingValue(
        text: formattedPhoneNumber,
        selection: TextSelection.collapsed(offset: formattedPhoneNumber.length),
      );
    }
  }

  FutureOr<void> _changeTouristFormVisibility(ChangeTouristFormVisibility event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      Map<Tourist, TouristFormState> newTourists = _getTourists();
      final bool newTouristFormVisibility = !(newTourists[event.tourist]?.isOpen ?? false);
      final TouristFormState? newState = newTourists[event.tourist]?.copyWith(isOpen: newTouristFormVisibility);
      newTourists[event.tourist] = newState ?? TouristFormState.create(isOpen: true);
      emit((state as ToursLoaded).copyWith(tourists: newTourists));
    }
  }

  Map<Tourist, TouristFormState> _getTourists() {
    return {...(state as ToursLoaded).tourists};
  }

  FutureOr<void> _onValidateInput(ValidateInput event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      add(ValidateMail());
      add(ValidatePhoneNumber());
      (state as ToursLoaded).tourists.values.forEach((element) {
        if (!element.isValid) {
          final Controller newNameController = element.controllers.nameController.copyWith(isModified: true);
          final Controller newSurNameController = element.controllers.surNameController.copyWith(isModified: true);
          final Controller newBirthDateController = element.controllers.birthDateController.copyWith(isModified: true);
          final Controller newCitizenshipController =
              element.controllers.citizenshipController.copyWith(isModified: true);
          final Controller newPassportNumberController =
              element.controllers.passportNumberController.copyWith(isModified: true);
          final Controller newPassportExpDateController =
              element.controllers.passportExpDateController.copyWith(isModified: true);

          Map<Tourist, TouristFormState> newTourists = _getTourists();
          newTourists.keys.forEach((key) {
            final TouristFormState? newState = newTourists[key]?.copyWith(
                controllers: TouristControllers.create(
              nameController: newNameController,
              surNameController: newSurNameController,
              birthDateController: newBirthDateController,
              citizenshipController: newCitizenshipController,
              passportNumberController: newPassportNumberController,
              passportExpDateController: newPassportExpDateController,
            ));
            newTourists[key] = newState ?? TouristFormState.create(isOpen: true);
          });
          emit((state as ToursLoaded).copyWith(isValid: false, tourists: newTourists));

          element.controllers.copyWith(
              nameController: newNameController,
              surNameController: newSurNameController,
              birthDateController: newBirthDateController,
              citizenshipController: newCitizenshipController,
              passportNumberController: newPassportNumberController,
              passportExpDateController: newPassportExpDateController);
        } else {
          emit((state as ToursLoaded).copyWith(isValid: true));
        }
      });
    }
  }

  FutureOr<void> _changeModifyStatus(ChangeModifyStatus event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      Map<Tourist, TouristFormState> newTourists = _getTourists();

      final controller = event.controller.copyWith(isModified: true);
      final TouristControllers? controllers = newTourists[event.tourist]?.controllers;
      final TouristControllers? newControllers = switch (event.controller.type) {
        ControllerType.name => controllers?.copyWith(nameController: controller),
        ControllerType.surName => controllers?.copyWith(surNameController: controller),
        ControllerType.birthDate => controllers?.copyWith(birthDateController: controller),
        ControllerType.citizenship => controllers?.copyWith(citizenshipController: controller),
        ControllerType.passportNumber => controllers?.copyWith(passportNumberController: controller),
        ControllerType.passportExpDate => controllers?.copyWith(passportExpDateController: controller),
      };
      final TouristFormState? newState = newTourists[event.tourist]?.copyWith(controllers: newControllers);

      newTourists[event.tourist] = newState ?? TouristFormState.create(isOpen: true);
      emit((state as ToursLoaded).copyWith(tourists: newTourists));
    }
  }

  FutureOr<void> _onValidateMail(ValidateMail event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      final String email = (state as ToursLoaded).emailController.text;
      final bool newMailStatus = EmailValidator.validate(email);
      emit((state as ToursLoaded).copyWith(isMailValid: newMailStatus, isMailModified: true));
    }
  }

  FutureOr<void> _onValidatePhoneNumber(ValidatePhoneNumber event, Emitter<ReservationState> emit) {
    if (state is ToursLoaded) {
      final String phoneNumber = (state as ToursLoaded).phoneNumberController.text;
      final bool newPhoneNumberStatus = phoneNumber.length == 16;
      emit((state as ToursLoaded).copyWith(isPhoneNumberValid: newPhoneNumberStatus, isPhoneNumberModified: true));
    }
  }
}
