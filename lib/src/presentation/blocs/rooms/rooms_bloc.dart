import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/domain/usecases/get_rooms_usecase.dart';
import 'package:injectable/injectable.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

@injectable
class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  final GetRoomsUsecase _getRoomsUsecase;

  RoomsBloc({
    required GetRoomsUsecase getRoomsUsecase,
  })  : _getRoomsUsecase = getRoomsUsecase,
        super(RoomsLoading()) {
    on<LoadRooms>(_onLoadRooms);
  }

  void _onLoadRooms(LoadRooms event, Emitter<RoomsState> emit) async {
    await _getRoomsUsecase().fold((failure) {
      emit(RoomsFailure(message: failure.toString()));
    }, (rooms) async {
      final loadedRooms = await rooms;
      emit(RoomsLoaded(rooms: loadedRooms));
    });
  }
}
