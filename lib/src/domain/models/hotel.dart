import 'package:hotel/src/domain/models/hotel_details.dart';

class Hotel {
  final int id;
  final String name;
  final String adress;
  final double? minimalPrice;
  final String? priceFor;
  final double? rating;
  final String? ratingName;
  final List<String> imageUrls;
  final HotelDetails? hotelDetails;

  const Hotel({
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
}
