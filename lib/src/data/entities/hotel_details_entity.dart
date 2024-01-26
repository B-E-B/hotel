import 'package:hotel/src/domain/models/hotel.dart';
import 'package:hotel/src/domain/models/hotel_details.dart';

class HotelDetailsEntity {
  final String description;
  final List<dynamic> peculiarities;

  HotelDetailsEntity({
    this.description = '',
    this.peculiarities = const [],
  });

  factory HotelDetailsEntity.fromJson(Map<String, dynamic> json) {
    return HotelDetailsEntity(
      description: json['description'],
      peculiarities: json['peculiarities'],
    );
  }

  factory HotelDetailsEntity.fromModel(Hotel hotel) {
    return HotelDetailsEntity(
      description: hotel.hotelDetails?.description ?? '',
      peculiarities: hotel.hotelDetails?.peculiarities ?? [],
    );
  }

  HotelDetails toModel() {
    return HotelDetails(
      description: description,
      peculiarities: peculiarities.map((e) => e.toString()).toList(),
    );
  }
}
