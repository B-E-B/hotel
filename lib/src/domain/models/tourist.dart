class Tourist {
  final int id;
  final String? name;
  final String? surName;
  final String? birthDate;
  final String? citizenship;
  final String? passportNumber;
  final String? passportExpDate;

  const Tourist({
    required this.id,
    this.name,
    this.surName,
    this.birthDate,
    this.citizenship,
    this.passportNumber,
    this.passportExpDate,
  });
}
