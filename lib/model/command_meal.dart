import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealDays {
  bool hasMer;
  bool hasJeu;
  bool hasVen;
  bool hasSam;
  bool hasDim;
  MealDays({
    required this.hasMer,
    required this.hasJeu,
    required this.hasVen,
    required this.hasSam,
    required this.hasDim,
  });
  factory MealDays.fromJson(Map<String, dynamic> json) {
    return MealDays(
      hasMer: json['hasMer'],
      hasJeu: json['hasJeu'],
      hasVen: json['hasVen'],
      hasSam: json['hasSam'],
      hasDim: json['hasDim'],
    );
  }
}

class CommandMeal {
  // String number;
  MealDays breakfast;
  MealDays lunch;
  MealDays dinner;
  CommandMeal({
    // required this.number,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory CommandMeal.fromJson(Map<String, dynamic> json) {
    return CommandMeal(
      // number: json['number'],
      breakfast: MealDays.fromJson(json['breakfast']),
      lunch: MealDays.fromJson(json['lunch']),
      dinner: MealDays.fromJson(json['dinner']),
    );
  }

  factory CommandMeal.empty() {
    return CommandMeal(
      // number: "",
      breakfast: MealDays(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
      lunch: MealDays(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
      dinner: MealDays(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
    );
  }

  static Future<CommandMeal?> fetchCommandMeal(String commandNumber) async {
    print('Fetching data');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String host = prefs.getString('host') ?? '192.168.43.152:8000';
    print(host);
    try {
      var response = await Dio()
          .get('http://$host/v2api/commands/$commandNumber/meals-status');
      if (response.statusCode == 200) {
        print("OK METY");
        return CommandMeal.fromJson(response.data);
      } else if (response.statusCode == 404) {
        print("SORRY, YOU DID NOT BUY TICKET MEAL");
      } else {
        print(response.data);
      }
    } on DioError catch (error) {
      if (error.response!.statusCode == 404) {
        print(error.response!.data["status"]);
        print("SORRY, YOU DID NOT BUY TICKET MEAL");
      } else {
        print(error);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
