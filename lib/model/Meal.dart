class Meal {
  int id;
  String type; // maraina, atoandro, hariva?
  String size; // lehibe, kely
  DateTime available;
  int? price;
  String? menu;

  // Simple constructor
  Meal(
      {required this.id,
      required this.type,
      required this.size,
      required this.available,
      this.price,
      this.menu});

  // from JSON factory
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as int,
      type: json['type'] as String,
      size: json['size'] as String,
      available: json['available'] as DateTime,
      price: json['price'] as int,
      menu: json['menu'] as String,
    );
  }
}
