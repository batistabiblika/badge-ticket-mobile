// import 'package:fbb_reg_ticket/home.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/screens/consume_meal_validated_screen.dart';
import 'package:fbb_reg_ticket/screens/home_screen/home_screen.dart';
import 'package:fbb_reg_ticket/screens/qr_test.dart';
// import 'package:fbb_reg_ticket/screens/qr_test.dart';
import 'package:fbb_reg_ticket/screens/scan_badge_screen/verify_badge_screen.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/configure_meal_ticket_screen.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/scan_meal_ticket_screen.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/verify_meal_ticket_screen.dart';
import 'package:fbb_reg_ticket/screens/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          '/': (BuildContext ctx) => const HomeScreen(),
          '/qr_test': (BuildContext ctx) => const QrTest(),
          '/scan_meal_ticket': (BuildContext ctx) =>
              const ScanMealTicketScreen(),
          '/verify_meal_ticket': (BuildContext ctx) =>
              const VerifyMealTicketScreen(),

          '/consume_meal': (BuildContext ctx) => const ConsumeMealScreen(
                ticketNumber: '001A',
              ),
          '/consume_validated': (BuildContext ctx) =>
              const ConsumeMealValidatedScreen(isSuccess: true),
          '/consume_refused': (BuildContext ctx) =>
              const ConsumeMealValidatedScreen(
                isSuccess: false,
                message: "REFUSED",
              ),
          '/consume_consumed': (BuildContext ctx) =>
              const ConsumeMealValidatedScreen(
                isSuccess: false,
                message: "CONSUMED",
              ),
          '/consume_invalid': (BuildContext ctx) =>
              const ConsumeMealValidatedScreen(
                isSuccess: false,
                message: "INVALID",
              ),
          '/consume_not_found': (BuildContext ctx) =>
              const ConsumeMealValidatedScreen(
                isSuccess: false,
                message: "NOT_FOUND",
              ),

          '/scan_badge': (BuildContext ctx) => const VerifyBadgeScreen(),

          // configuration
          '/config_meal': (BuildContext ctx) =>
              const ConfigureMealTicketScreen(),
          '/settings': (BuildContext ctx) => const SettingScreen(),
        });
  }

  ThemeData _lightTheme() {
    return ThemeData(
        // This is the theme of your application.
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: AppColors.WHITE,
        useMaterial3: false,

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
