part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class LoadTours extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class AddTourist extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class PhoneNumberInput extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class ValidateInput extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class ValidateMail extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class ValidatePhoneNumber extends ReservationEvent {
  @override
  List<Object?> get props => [];
}

class ChangeModifyStatus extends ReservationEvent {
  final Tourist tourist;
  final Controller controller;

  const ChangeModifyStatus({required this.controller, required this.tourist});
  @override
  List<Object?> get props => [
        tourist,
      ];
}

class ChangeTouristFormVisibility extends ReservationEvent {
  final Tourist tourist;

  const ChangeTouristFormVisibility({required this.tourist});
  @override
  List<Object?> get props => [
        tourist,
      ];
}
