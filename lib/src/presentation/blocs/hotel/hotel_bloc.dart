import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/usecases/get_hotels_usecase.dart';
import 'package:injectable/injectable.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

@injectable
class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotelsUsecase _getHotelsUsecase;

  HotelBloc({
    required GetHotelsUsecase getHotelsUsecase,
  })  : _getHotelsUsecase = getHotelsUsecase,
        super(HotelsLoading()) {
    on<LoadHotels>(_onLoadHotels);
  }

  void _onLoadHotels(LoadHotels event, Emitter<HotelState> emit) async {
    await _getHotelsUsecase().fold((failure) {
      emit(HotelsFailure(message: failure.toString()));
    }, (hotels) async {
      final loadedHotels = await hotels;
      emit(HotelsLoaded(hotels: loadedHotels));
    });
  }
}
