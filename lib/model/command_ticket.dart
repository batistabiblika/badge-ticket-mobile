import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fbb_reg_ticket/model/bus_ticket.dart';
import 'package:fbb_reg_ticket/model/days_status.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Map to command ticket object from API
 */
class CommandTicket {
  String? number;
  String? size;
  BusTicket? bus;
  DaysStatus breakfast;
  DaysStatus lunch;
  DaysStatus dinner;
  DaysStatus sleeping;
  CommandTicket({
    this.number,
    this.size,
    // required this.number,
    this.bus,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.sleeping,
  });

  factory CommandTicket.fromJson(Map<String, dynamic> json) {
    return CommandTicket(
      number: json['number'],
      size: json['size'],
      bus: BusTicket.fromJson(json['bus']),
      breakfast: DaysStatus.fromJson(json['breakfast']),
      lunch: DaysStatus.fromJson(json['lunch']),
      dinner: DaysStatus.fromJson(json['dinner']),
      sleeping: DaysStatus.fromJson(json['sleeping']),
    );
  }

  factory CommandTicket.empty() {
    return CommandTicket(
      number: "",
      size: "",
      bus: BusTicket(mer: "", jeu: "", ven: "", sam: "", dim: ""),
      breakfast: DaysStatus(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
      lunch: DaysStatus(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
      dinner: DaysStatus(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
      sleeping: DaysStatus(
          hasMer: false,
          hasJeu: false,
          hasVen: false,
          hasSam: false,
          hasDim: false),
    );
  }

  /**
   * Load command ticket from API
   */
  static Future<dynamic?> fetchCommandTicket(String commandNumber) async {
    print('Fetching data');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String host = prefs.getString('host') ?? AppSettings.HOST;
    print(host);
    try {
      var response =
          await Dio().get('$host/v2api/commands/$commandNumber/meals-status');
      // .get('$host/v2api/commands/$commandNumber/meals-status');
      if (response.statusCode == 200) {
        return CommandTicket.fromJson(response.data);
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

  /**
   * Consume command ticket
   */
  static Future<String?> consumeCommandTicket(String commandNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Fetching data');
    String host = prefs.getString('host') ?? AppSettings.HOST;
    // TODO : load MEAL DAY HERE
    String mealDay = prefs.getString('mealDay') ?? AppSettings.MEAL_DAY;
    String mealType = prefs.getString('mealType') ?? AppSettings.MEAL_TYPE;
    print('mealDay $mealDay mealType $mealType');
    // print('$host/v2api/commands/$commandNumber/consume/$mealDay/$mealType');
    try {
      var response = await Dio().post(
          '$host/v2api/commands/$commandNumber/consume/$mealDay/$mealType');
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

  /*  static Widget configurationInformationWidget() {
    Future<String> getMealConfig() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String mealDay = prefs.getString('mealDay') ?? AppSettings.MEAL_DAY;
      String mealType = prefs.getString('mealType') ?? AppSettings.MEAL_TYPE;
      switch (mealType.toUpperCase()) {
        case "BREAKFAST":
          // mealType = "Petit déjeuner";
          mealType = "Sakafo maraina";
          break;
        case "LUNCH":
          // mealType = "Déjeuner";
          mealType = "Sakafo atoandro";
          break;
        case "DINNER":
          // mealType = "Dinner";
          mealType = "Sakafo hariva";
          break;
      }
      switch (mealDay.toUpperCase()) {
        case "MER":
          // mealDay = "Mercredi";
          mealDay = "Alarobia";
          break;
        case "JEU":
          // mealDay = "Jeudi";
          mealDay = "Alakamisy";
          break;
        case "VEN":
          // mealDay = "Vendredi";
          mealDay = "Zoma";
          break;
        case "SAM":
          // mealDay = "Samedi";
          mealDay = "Sabotsy";
          break;
        case "DIM":
          // mealDay = "Dimanche";
          mealDay = "Alahady";
          break;
      }
      return ('${mealType}n\'ny $mealDay');
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.BORDER),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            "Repas concerné :",
            style: AppTextStyle.text(),
            textAlign: TextAlign.center,
          ),
          FutureBuilder(
            future: getMealConfig(),
            builder: ((context, snapshot) {
              if (snapshot.hasData && snapshot.data is String) {
                return Text(
                  snapshot.data as String,
                  style: AppTextStyle.text(),
                  textAlign: TextAlign.center,
                );
              }
              return SizedBox();
            }),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
 */
}
