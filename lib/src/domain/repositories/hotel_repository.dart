import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/domain/models/tour.dart';

abstract class HotelRepository {
  Future<List<Hotel>> getHotels();
  Future<List<Room>> getRooms();
  Future<List<Tour>> getTours();
}
