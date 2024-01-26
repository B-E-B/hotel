part of 'hotel_bloc.dart';

abstract class HotelState extends Equatable {
  const HotelState();
  @override
  List<Object> get props => [];
}

class HotelsLoading extends HotelState {
  @override
  List<Object> get props => [];
}

class HotelsLoaded extends HotelState {
  final List<Hotel> hotels;

  const HotelsLoaded({required this.hotels});
  @override
  List<Object> get props => [hotels];
}

class HotelsFailure extends HotelState {
  final String message;

  const HotelsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
