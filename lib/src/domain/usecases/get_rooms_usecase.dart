import 'package:dartz/dartz.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/domain/repositories/hotel_repository.dart';
import 'package:hotel/src/domain/usecases/result_handler/result_handler.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetRoomsUsecase {
  final HotelRepository _hotelRepository;

  GetRoomsUsecase(this._hotelRepository);

  Either<Failure, Future<List<Room>>> call() {
    try {
      return Right(_hotelRepository.getRooms());
    } catch (e, s) {
      return Left(
        Failure(
          exception: e,
          stackTrace: s,
          message: e.toString(),
        ),
      );
    }
  }
}
