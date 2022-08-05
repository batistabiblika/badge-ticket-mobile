// import 'package:fbb_reg_ticket/home.dart';
import 'package:fbb_reg_ticket/screens/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/screens/consume_meal_validated_screen.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_ticket_form_screen.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: _lightTheme(),
        // home: const HomeTicket(title: 'Ticket Sakafo Home'),
        routes: {
          '/': (BuildContext ctx) => ScanMealTicketFormScreen(),
          '/consume_meal': (BuildContext ctx) => ConsumeMealScreen(
                ticketNumber: '001A',
              ),
          '/consume_validated': (BuildContext ctx) =>
              ConsumeMealValidatedScreen(),
        });
  }

  ThemeData _lightTheme() {
    return ThemeData(
        // This is the theme of your application.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: AppColors.WHITE,

        // fontFamily
        // fontFamily: 'Georgia',
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: TextTheme(
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),

        // textButton theme
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: AppColors.DARK)),

        // Defining global appBar Theme
        appBarTheme: AppBarTheme(
            // color: Colors.white,
            // backgroundColor: Colors.white,
            backgroundColor: AppColors.PRIMARY,
            foregroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.WHITE),
            toolbarTextStyle: const TextTheme(
              headline6: TextStyle(color: AppColors.WHITE, fontSize: 20),
            ).bodyText2,
            titleTextStyle: const TextTheme(
              headline6: TextStyle(
                  color: AppColors.WHITE,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ).headline6),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.black54));
  }
}
