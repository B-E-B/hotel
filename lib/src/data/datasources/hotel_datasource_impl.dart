import 'package:dio/dio.dart';
import 'package:hotel/src/data/datasources/hotel_datasource.dart';
import 'package:hotel/src/data/entities/hotel_entity.dart';
import 'package:hotel/src/data/entities/room_entity.dart';
import 'package:hotel/src/data/entities/tour_entity.dart';
import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/models/room.dart';
import 'package:hotel/src/domain/models/tour.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HotelDatasource)
class HotelDataSourceImpl extends HotelDatasource {
  final Dio dio = Dio();

  @override
  Future<List<Hotel>> getHotels() async {
    final response = await dio.get('https://run.mocky.io/v3/75000507-da9a-43f8-a618-df698ea7176d');
    if (response.statusCode == 200) {
      List<Hotel> hotels = [HotelEntity.fromJson(response.data).toModel()];

      return hotels;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  @override
  Future<List<Room>> getRooms() async {
    final response = await dio.get('https://run.mocky.io/v3/157ea342-a8a3-4e00-a8e6-a87d170aa0a2');
    if (response.statusCode == 200) {
      List<Room> rooms = (response.data['rooms'] as List<dynamic>)
          .map((room) => RoomEntity.fromJson(room as Map<String, dynamic>).toModel())
          .toList();

      return rooms;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  @override
  Future<List<Tour>> getTours() async {
    final response = await dio.get('https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff');
    if (response.statusCode == 200) {
      List<Tour> tours = [TourEntity.fromJson(response.data).toModel()];

      return tours;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
