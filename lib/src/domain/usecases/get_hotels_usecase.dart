import 'package:dartz/dartz.dart';
import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/repositories/hotel_repository.dart';
import 'package:hotel/src/domain/usecases/result_handler/result_handler.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetHotelsUsecase {
  final HotelRepository _hotelRepository;

  GetHotelsUsecase(this._hotelRepository);

  Either<Failure, Future<List<Hotel>>> call() {
    try {
      return Right(_hotelRepository.getHotels());
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
