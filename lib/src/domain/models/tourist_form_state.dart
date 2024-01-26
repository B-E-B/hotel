import 'package:hotel/src/domain/models/tourist_controllers.dart';

class TouristFormState {
  final TouristControllers controllers;
  final bool isOpen;

  TouristFormState.create({
    required this.isOpen,
    TouristControllers? controllers,
  }) : controllers = controllers ?? TouristControllers.create();

  Controller get nameController => controllers.nameController;
  Controller get surNameController => controllers.surNameController;
  Controller get birthDateController => controllers.birthDateController;
  Controller get citizenshipController => controllers.citizenshipController;
  Controller get passportNumberController => controllers.passportNumberController;
  Controller get passportExpDateController => controllers.passportExpDateController;
  bool get isValid {
    return nameController.text.isNotEmpty &&
        surNameController.text.isNotEmpty &&
        birthDateController.text.isNotEmpty &&
        passportNumberController.text.isNotEmpty &&
        passportExpDateController.text.isNotEmpty;
  }

  bool get isNameValid => nameController.text.isNotEmpty;
  bool get isSurNameValid => surNameController.text.isNotEmpty;
  bool get isBirthDateValid => birthDateController.text.isNotEmpty;
  bool get isCitizenshipValid => citizenshipController.text.isNotEmpty;
  bool get isPassportNumberValid => passportNumberController.text.isNotEmpty;
  bool get isPassportExpDateValid => passportExpDateController.text.isNotEmpty;

  TouristFormState copyWith({
    bool? isOpen,
    TouristControllers? controllers,
  }) {
    return TouristFormState.create(
      isOpen: isOpen ?? this.isOpen,
      controllers: controllers ?? this.controllers,
    );
  }
}
