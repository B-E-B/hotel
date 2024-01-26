import 'package:dartz/dartz.dart';
import 'package:hotel/src/domain/models/tour.dart';
import 'package:hotel/src/domain/repositories/hotel_repository.dart';
import 'package:hotel/src/domain/usecases/result_handler/result_handler.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetToursUsecase {
  final HotelRepository _hotelRepository;

  GetToursUsecase(this._hotelRepository);

  Either<Failure, Future<List<Tour>>> call() {
    try {
      return Right(_hotelRepository.getTours());
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
