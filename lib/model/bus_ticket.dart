class BusTicket {
  final String id;
  final String lineDirection;
  final int quantity;

  // replace this by badge object later
  // Badge linkedToBadge;
  final String linkedToName;

  // bus ticket
  const BusTicket({
    required this.id,
    required this.lineDirection,
    required this.quantity,
    required this.linkedToName,
  });

  factory BusTicket.fromJson(Map<String, dynamic> json) {
    return BusTicket(
      id: json['id'],
      lineDirection: json['lineDirection'],
      quantity: json['quantity'],
      linkedToName: json['linkedToName'],
    );
  }
}
