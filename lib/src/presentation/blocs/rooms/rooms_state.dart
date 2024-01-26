part of 'rooms_bloc.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();
  @override
  List<Object> get props => [];
}

class RoomsLoading extends RoomsState {
  @override
  List<Object> get props => [];
}

class RoomsLoaded extends RoomsState {
  final List<Room> rooms;

  const RoomsLoaded({required this.rooms});
  @override
  List<Object> get props => [rooms];
}

class RoomsFailure extends RoomsState {
  final String message;

  const RoomsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
