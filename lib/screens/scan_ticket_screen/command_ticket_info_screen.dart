import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/model/command_ticket.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_ticket_screen/components/command_ticket_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandTicketInfoScreen extends StatefulWidget {
  final String ticketNumber;
  const CommandTicketInfoScreen({Key? key, required this.ticketNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommandTicketInfoScreen();
}

class _CommandTicketInfoScreen extends State<CommandTicketInfoScreen> {
  String _ticketNumber = "";

  @override
  Widget build(BuildContext context) {
    // widget.badgeNumber return the badge
    _ticketNumber = widget.ticketNumber;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Information ticket"),
      ),
      body: SafeArea(
        child: Stack(children: [_content(), _bottomBar()]),
      ),
    );
  }

  Widget _content() {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.MARGIN_Y, horizontal: AppSizes.MARGIN_X),
      shrinkWrap: false,
      // children: [BadgeInfoWidget(badge: _badge)],
      children: [
        FutureBuilder(
            future: CommandTicket.fetchCommandTicket(_ticketNumber),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occured'),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data is CommandTicket) {
                  CommandTicket commandMeal = snapshot.data as CommandTicket;
                  // print(badge.image);
                  return CommandTicketInfoWidget(
                    number: _ticketNumber,
                    commandMeal: commandMeal,
                    showSleeping: true,
                  );
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
