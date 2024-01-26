part of 'reservation_bloc.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();
}

class ToursLoading extends ReservationState {
  @override
  List<Object> get props => [];
}

class ToursLoaded extends ReservationState {
  final List<Tour> tours;
  final int previousPhoneLenght;
  final bool isValid;
  final Map<Tourist, TouristFormState> tourists;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final bool isPhoneNumberValid;
  final bool isPhoneNumberModified;
  final bool isMailValid;
  final bool isMailModified;

  ToursLoaded({
    this.isValid = false,
    this.tours = const <Tour>[],
    this.previousPhoneLenght = 0,
    this.isMailValid = false,
    this.isPhoneNumberValid = false,
    this.isPhoneNumberModified = false,
    this.isMailModified = false,
    required this.emailController,
    required this.phoneNumberController,
    required this.tourists,
  });

  ToursLoaded copyWith({
    bool? isValid,
    List<Tour>? tours,
    Map<Tourist, TouristFormState>? tourists,
    int? previousPhoneLenght,
    bool? isPhoneNumberValid,
    bool? isMailValid,
    bool? isPhoneNumberModified,
    bool? isMailModified,
    TextEditingController? phoneNumberController,
    TextEditingController? emailController,
  }) {
    return ToursLoaded(
      tours: tours ?? this.tours,
      tourists: tourists ?? this.tourists,
      isValid: isValid ?? this.isValid,
      previousPhoneLenght: previousPhoneLenght ?? this.previousPhoneLenght,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isMailValid: isMailValid ?? this.isMailValid,
      isPhoneNumberModified: isPhoneNumberModified ?? this.isPhoneNumberModified,
      isMailModified: isMailModified ?? this.isMailModified,
      phoneNumberController: phoneNumberController ?? this.phoneNumberController,
      emailController: emailController ?? this.emailController,
    );
  }

  @override
  List<Object> get props => [
        tours,
        tourists,
        isValid,
        previousPhoneLenght,
        isPhoneNumberValid,
        isMailValid,
        isPhoneNumberModified,
        isMailModified
      ];
}

class ToursFailure extends ReservationState {
  final String message;

  const ToursFailure({required this.message});

  @override
  List<Object> get props => [message];
}
