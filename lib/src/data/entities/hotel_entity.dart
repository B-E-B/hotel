import 'package:hotel/src/data/entities/hotel_details_entity.dart';
import 'package:hotel/src/domain/models/hotel.dart';

class HotelEntity {
  final int id;
  final String name;
  final String adress;
  final num? minimalPrice;
  final String? priceFor;
  final num? rating;
  final String? ratingName;
  final List<dynamic> imageUrls;
  final HotelDetailsEntity? hotelDetails;

  const HotelEntity({
    required this.id,
    required this.name,
    required this.adress,
    this.minimalPrice,
    this.priceFor,
    this.rating,
    this.ratingName,
    this.imageUrls = const [],
    this.hotelDetails,
  });
  factory HotelEntity.fromJson(Map<String, dynamic> json) {
    return HotelEntity(
      id: json['id'],
      name: json['name'],
      adress: json['adress'],
      minimalPrice: json['minimal_price'],
      priceFor: json['price_for_it'],
      rating: json['rating'],
      ratingName: json['rating_name'],
      imageUrls: json['image_urls'],
      hotelDetails: HotelDetailsEntity.fromJson(json['about_the_hotel']),
    );
  }

  factory HotelEntity.fromModel(Hotel hotel) {
    return HotelEntity(
      id: hotel.id,
      name: hotel.name,
      adress: hotel.adress,
      minimalPrice: hotel.minimalPrice,
      priceFor: hotel.priceFor.toString(),
      rating: hotel.rating,
      ratingName: hotel.ratingName,
      imageUrls: hotel.imageUrls,
      hotelDetails: HotelDetailsEntity.fromModel(hotel),
    );
  }

  Hotel toModel() {
    return Hotel(
      id: id,
      name: name,
      adress: adress,
      minimalPrice: minimalPrice?.toDouble(),
      priceFor: priceFor,
      rating: rating?.toDouble(),
      ratingName: ratingName,
      imageUrls: imageUrls.map((e) => e.toString()).toList(),
      hotelDetails: hotelDetails?.toModel(),
    );
  }
}
