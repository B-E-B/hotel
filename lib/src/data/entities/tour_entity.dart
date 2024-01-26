import 'package:hotel/src/domain/models/tour.dart';

class TourEntity {
  final int id;
  final String hotelName;
  final String hotelAdress;
  final num? rating;
  final String? ratingName;
  final String departure;
  final String arrival;
  final String dateOfDeparture;
  final String dateOfArrival;
  final int numberOfNights;
  final String room;
  final String nutrition;
  final num tourPrise;
  final num? fuelCharge;
  final num? serviceCharge;

  const TourEntity({
    required this.id,
    required this.hotelName,
    required this.hotelAdress,
    this.rating,
    this.ratingName,
    required this.departure,
    required this.arrival,
    required this.dateOfDeparture,
    required this.dateOfArrival,
    required this.numberOfNights,
    required this.room,
    required this.nutrition,
    required this.tourPrise,
    this.fuelCharge,
    this.serviceCharge,
  });

  factory TourEntity.fromJson(Map<String, dynamic> json) {
    return TourEntity(
      id: json['id'],
      hotelName: json['hotel_name'],
      hotelAdress: json['hotel_adress'],
      rating: json['horating'],
      ratingName: json['rating_name'],
      departure: json['departure'],
      arrival: json['arrival_country'],
      dateOfDeparture: json['tour_date_start'],
      dateOfArrival: json['tour_date_stop'],
      numberOfNights: json['number_of_nights'],
      room: json['room'],
      nutrition: json['nutrition'],
      tourPrise: json['tour_price'],
      fuelCharge: json['fuel_charge'],
      serviceCharge: json['service_charge'],
    );
  }

  factory TourEntity.fromModel(Tour tour) {
    return TourEntity(
      id: tour.id,
      hotelName: tour.hotelName,
      hotelAdress: tour.hotelAdress,
      rating: tour.rating,
      departure: tour.departure,
      arrival: tour.arrival,
      dateOfDeparture: tour.dateOfDeparture,
      dateOfArrival: tour.dateOfArrival,
      numberOfNights: tour.numberOfNights,
      room: tour.room,
      nutrition: tour.nutrition,
      tourPrise: tour.price,
      fuelCharge: tour.fuelCharge,
      serviceCharge: tour.serviceCharge,
    );
  }

  Tour toModel() {
    return Tour(
      id: id,
      hotelName: hotelName,
      hotelAdress: hotelAdress,
      rating: rating,
      ratingName: ratingName,
      departure: departure,
      arrival: arrival,
      dateOfDeparture: dateOfDeparture,
      dateOfArrival: dateOfArrival,
      numberOfNights: numberOfNights,
      room: room,
      nutrition: nutrition,
      price: tourPrise,
      fuelCharge: fuelCharge,
      serviceCharge: serviceCharge,
      totalPrice: tourPrise + (fuelCharge ?? 0) + (serviceCharge ?? 0),
    );
  }
}
