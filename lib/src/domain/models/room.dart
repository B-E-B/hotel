class Room {
  final int id;
  final String name;
  final num price;
  final String priceFor;
  final List<dynamic> peculiarities;
  final List<dynamic> imageUrls;

  const Room({
    required this.id,
    required this.name,
    required this.price,
    required this.priceFor,
    required this.peculiarities,
    required this.imageUrls,
  });
}
