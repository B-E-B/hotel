import 'package:hotel/src/domain/models/room.dart';

class RoomEntity {
  final int id;
  final String name;
  final num price;
  final String pricePer;
  final List<dynamic> peculiarities;
  final List<dynamic> imageUrls;

  const RoomEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.pricePer,
    required this.peculiarities,
    required this.imageUrls,
  });

  factory RoomEntity.fromJson(Map<String, dynamic> json) {
    return RoomEntity(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      pricePer: json['price_per'],
      peculiarities: json['peculiarities'],
      imageUrls: json['image_urls'],
    );
  }

  factory RoomEntity.fromModel(Room room) {
    return RoomEntity(
      id: room.id,
      name: room.name,
      price: room.price,
      pricePer: room.priceFor,
      peculiarities: room.peculiarities,
      imageUrls: room.imageUrls,
    );
  }

  Room toModel() {
    return Room(
      id: id,
      name: name,
      price: price,
      priceFor: pricePer,
      peculiarities: peculiarities,
      imageUrls: imageUrls,
    );
  }
}
