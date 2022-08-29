class BusTicket {
  String mer; // axe_1, axe_2
  String jeu;
  String ven;
  String sam;
  String dim;

  // bus ticket
  BusTicket({
    required this.mer,
    required this.jeu,
    required this.ven,
    required this.sam,
    required this.dim,
  });

  factory BusTicket.fromJson(Map<String, dynamic> json) {
    return BusTicket(
      mer: json['MER'],
      jeu: json['JEU'],
      ven: json['VEN'],
      sam: json['SAM'],
      dim: json['DIM'],
    );
  }
}
