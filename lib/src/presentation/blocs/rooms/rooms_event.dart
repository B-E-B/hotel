part of 'rooms_bloc.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
}

class LoadRooms extends RoomsEvent {
  @override
  List<Object?> get props => [];
}
