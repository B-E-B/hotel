import 'package:hotel/src/data/datasources/hotel_datasource.dart';
import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/domain/models/tour.dart';
import 'package:hotel/src/domain/repositories/hotel_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HotelRepository)
class HotelRepositoryImpl extends HotelRepository {
  final HotelDatasource hotelDataSource;

  HotelRepositoryImpl(this.hotelDataSource);

  @override
  Future<List<Hotel>> getHotels() async {
    final List<Hotel> hotels = await hotelDataSource.getHotels();

    if (hotels.isEmpty) {
      throw Exception('Failed to get hotels');
    }
    return hotels;
  }

  @override
  Future<List<Room>> getRooms() async {
    final List<Room> rooms = await hotelDataSource.getRooms();

    if (rooms.isEmpty) {
      throw Exception('Failed to get rooms');
    }
    return rooms;
  }

  @override
  Future<List<Tour>> getTours() async {
    final List<Tour> tours = await hotelDataSource.getTours();

    if (tours.isEmpty) {
      throw Exception('Failed to get tours');
    }
    return tours;
  }
}
