class Ingredient {
  Ingredient({
    this.id,
    required this.name,
    required this.amount,
    required this.unit,
    this.tag,
  });
  String? id;
  String name;
  int? amount;
  String unit;
  String? tag;
}
