class Tour {
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
  final num price;
  final num? fuelCharge;
  final num? serviceCharge;
  final num totalPrice;

  const Tour({
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
    required this.price,
    this.fuelCharge,
    this.serviceCharge,
    required this.totalPrice,
  });
}
