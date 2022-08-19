import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fbb_reg_ticket/res/values.dart';
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

  /* static Future<dynamic?> fetchCommandMeal(String commandNumber) async {
    var client = Client();
    print('Fetching data');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String host = prefs.getString('host') ?? '192.168.43.152:8000';
    print(host);
    try {
      var response = await client.get(
          Uri.parse('http://$host/v2api/commands/$commandNumber/meals-status'));
      if (response.statusCode == 200) {
        print("OK METY");
        return CommandMeal.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        print("SORRY, YOU DID NOT BUY TICKET MEAL");
      } else {
        print(response.body);
      }
      return ("NOT_FOUND");
    } on DioError catch (error) {
      if (error.response == null) {
        return ("NETWORK_ERROR");
      } else if (error.response!.statusCode == 404) {
        print(error.response!.data["status"]);
        print("SORRY, MEAL TICKET NOT FOUND");
        return (error.response!.data["status"] ?? "NOT_FOUND");
      } else {
        print(error);
        return ("OTHER_CONNNECTION_ERROR");
      }
    } catch (e) {
      print(e);
      print("SORRY, MEAL TICKET NOT FOUND");
    }
    return null;
  } */

  static Future<dynamic?> fetchCommandMeal(String commandNumber) async {
    print('Fetching data');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String host = prefs.getString('host') ?? AppSettings.HOST;
    print(host);
    try {
      var response = await Dio()
          .get('http://$host/v2api/commands/$commandNumber/meals-status');
      if (response.statusCode == 200) {
        return CommandMeal.fromJson(response.data);
        // } else if (response.statusCode == 404) {
        //   print("SORRY, YOU DID NOT BUY TICKET MEAL");
        //   return ("NOT_FOUND");
      } else {
        print(response.data);
      }
      return ("NOT_FOUND");
    } on DioError catch (error) {
      if (error.response == null) {
        return ("NETWORK_ERROR");
      } else if (error.response!.statusCode == 404) {
        if (error.response!.data is String) {
          print(error.response!.data);
          // return (error.response!.data);
          return ("NO_ROUTE_FOUND");
        }
        print(error.response!.data["status"]);
        print("SORRY, MEAL TICKET NOT FOUND");
        return ("NOT_FOUND");
        // return (error.response!.data["status"] as String ?? "NOT_FOUND");
      } else {
        print(error);
        return ("OTHER_CONNNECTION_ERROR");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<String?> consumeCommandMeal(String commandNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Fetching data');
    String host = prefs.getString('host') ?? AppSettings.HOST;
    // TODO : load MEAL DAY HERE
    String mealDay = prefs.getString('mealDay') ?? AppSettings.MEAL_DAY;
    String mealType = prefs.getString('mealType') ?? AppSettings.MEAL_TYPE;
    print('mealDay $mealDay mealType $mealType');
    print(
        'http://$host/v2api/commands/$commandNumber/consume/$mealDay/$mealType');
    try {
      var response = await Dio().post(
          'http://$host/v2api/commands/$commandNumber/consume/$mealDay/$mealType');
      return "VALIDATED";
    } on DioError catch (error) {
      if (error.response == null) {
        return "NETWORK_ERROR";
      }
      if (error.response!.data is String) {
        print(error.response!.data);
        // return (error.response!.data);
        return ("NO_ROUTE_FOUND");
      }
      return (error.response!.data["code_error"] ?? "NOT_FOUND");
    } catch (error) {
      print(error);
      return "ERROR";
    }
  }
}
