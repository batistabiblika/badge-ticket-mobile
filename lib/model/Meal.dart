class Meal {
  int id;
  String type; // maraina, atoandro, hariva?
  String size; // lehibe, kely
  DateTime available;
  int? price;
  String? menu;

  // Simple constructor
  Meal(this.id, this.type, this.size,  this.available, this.price, this.menu);

  // from JSON factory
  Meal.fromJson(
      {required this.id,
      required this.type,
      required this.size,
      required this.available,
      this.price,
      this.menu});
}
