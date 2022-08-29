
class DaysStatus {
  bool hasMer;
  bool hasJeu;
  bool hasVen;
  bool hasSam;
  bool hasDim;
  DaysStatus({
    required this.hasMer,
    required this.hasJeu,
    required this.hasVen,
    required this.hasSam,
    required this.hasDim,
  });
  factory DaysStatus.fromJson(Map<String, dynamic> json) {
    return DaysStatus(
      hasMer: json['hasMer'],
      hasJeu: json['hasJeu'],
      hasVen: json['hasVen'],
      hasSam: json['hasSam'],
      hasDim: json['hasDim'],
    );
  }
}
