import 'package:flutter/material.dart';

class TouristControllers {
  final Controller nameController;
  final Controller surNameController;
  final Controller birthDateController;
  final Controller citizenshipController;
  final Controller passportNumberController;
  final Controller passportExpDateController;

  TouristControllers.create({
    Controller? nameController,
    Controller? surNameController,
    Controller? birthDateController,
    Controller? citizenshipController,
    Controller? passportNumberController,
    Controller? passportExpDateController,
  })  : nameController = nameController ?? Controller(type: ControllerType.name),
        surNameController = surNameController ?? Controller(type: ControllerType.surName),
        birthDateController = birthDateController ?? Controller(type: ControllerType.birthDate),
        citizenshipController = citizenshipController ?? Controller(type: ControllerType.citizenship),
        passportNumberController = passportNumberController ?? Controller(type: ControllerType.passportNumber),
        passportExpDateController = passportExpDateController ?? Controller(type: ControllerType.passportExpDate);

  TouristControllers copyWith({
    Controller? nameController,
    Controller? surNameController,
    Controller? birthDateController,
    Controller? citizenshipController,
    Controller? passportNumberController,
    Controller? passportExpDateController,
  }) {
    return TouristControllers.create(
      nameController: nameController ?? this.nameController,
      surNameController: surNameController ?? this.surNameController,
      birthDateController: birthDateController ?? this.birthDateController,
      citizenshipController: citizenshipController ?? this.citizenshipController,
      passportNumberController: passportNumberController ?? this.passportNumberController,
      passportExpDateController: passportExpDateController ?? this.passportExpDateController,
    );
  }
}

class Controller {
  final bool isModified;
  final ControllerType type;
  final TextEditingController controller;

  Controller({
    this.isModified = false,
    TextEditingController? controller,
    required this.type,
  }) : controller = controller ?? TextEditingController();

  String get text => controller.text;
  Controller copyWith({
    bool? isModified,
  }) {
    return Controller(
      isModified: isModified ?? this.isModified,
      type: type,
      controller: controller,
    );
  }
}

enum ControllerType {
  name,
  surName,
  birthDate,
  citizenship,
  passportNumber,
  passportExpDate,
}
