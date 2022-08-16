// Ticket mifanaraka amin'ny command. Ito no mirepresenté ny ticket
import 'package:fbb_reg_ticket/model/meal.dart';
import 'package:http/http.dart' as http;

class CommandCamp {
  String id;
  int campId;
  String campName;
  String status;
  String size;
  bool? staySleeping;
  bool? withMeals;
  int quantity;
  int breakfastQttConsumed;
  int lunchQttConsumed;
  int dinnerQttConsumed;

  // Constructor
  CommandCamp(
      {required this.id,
      required this.campId,
      required this.campName,
      required this.status,
      required this.size,
      this.staySleeping,
      this.withMeals,
      required this.quantity,
      required this.breakfastQttConsumed,
      required this.lunchQttConsumed,
      required this.dinnerQttConsumed});

  // from JSON factory
  factory CommandCamp.fromJson(Map<String, dynamic> json) {
    return CommandCamp(
      id: json['id'] as String,
      campId: json['campId'] as int,
      campName: json['campName'],
      status: json['status'],
      size: json['size'],
      staySleeping: json['staySleeping'],
      withMeals: json['withMeals'],
      quantity: json['quantity'],
      breakfastQttConsumed: json['breakfastQttConsumed'],
      lunchQttConsumed: json['lunchQttConsumed'],
      dinnerQttConsumed: json['dinnerQttConsumed'],
    );
  }

  /* static Future<CommandCamp> fetchCommandCamp(http.Client client, String commandNumberId, String commandCampId) async {
    response = ac
  } */
  /* static Future<CommandCamp> consumeCommandCamp(http.Client client, String commandNumberId, String commandCampId) async {
    response = ac
  } */
}
