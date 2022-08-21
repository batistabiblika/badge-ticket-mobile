import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/model/command_meal.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/components/meal_ticket_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealTicketInfoScreen extends StatefulWidget {
  final String ticketNumber;
  const MealTicketInfoScreen({Key? key, required this.ticketNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MealTicketInfoScreen();
}

class _MealTicketInfoScreen extends State<MealTicketInfoScreen> {
  String _ticketNumber = "";

  @override
  Widget build(BuildContext context) {
    // widget.badgeNumber return the badge
    _ticketNumber = widget.ticketNumber;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Information ticket repas"),
      ),
      body: SafeArea(
        child: Stack(children: [_content(), _bottomBar()]),
      ),
    );
  }

  Widget _content() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shrinkWrap: true,
      // children: [BadgeInfoWidget(badge: _badge)],
      children: [
        FutureBuilder(
            future: CommandMeal.fetchCommandMeal(_ticketNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occured'),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data is CommandMeal) {
                  CommandMeal commandMeal = snapshot.data as CommandMeal;
                  // print(badge.image);
                  return MealTicketInfoWidget(
                      number: _ticketNumber, commandMeal: commandMeal);
                } else if (snapshot.data is String) {
                  switch (snapshot.data as String) {
                    case "NOT_FOUND":
                      return // Badge n%
                          Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: AppColors.RED,
                                size: 80,
                              ),
                              Text(
                                'Ticket repas non-existant!',
                                textAlign: TextAlign.center,
                                style:
                                    AppTextStyle.text(color: AppColors.PRIMARY),
                              ),
                              Text(
                                'N° $_ticketNumber',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.head2(color: AppColors.RED),
                              ),
                            ]),
                      );
                      break;
                    default:
                      return Text(snapshot.data as String);
                  }
                } else {
                  return Text("Error");
                }
              } else {
                return const Center(
                  child: Text('Loading ...'),
                );
              }
            }),
      ],
    );
  }

  Widget _bottomBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: BottomAppBar(
        elevation: 0,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          child: ButtonSolid(
            "Vérifier un autre ticket",
            icon: CupertinoIcons.tickets,
            color: AppColors.PRIMARY,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/verify_meal_ticket');
            },
          ),
        ),
      ),
    );
  }
}
