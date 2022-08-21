import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/model/command_meal.dart';
import 'package:fbb_reg_ticket/screens/qr_screen/qr_screen.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/components/meal_ticket_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyMealTicketScreen extends StatefulWidget {
  // declaration
  const VerifyMealTicketScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyMealTicketScreenState();
}

class _VerifyMealTicketScreenState extends State<VerifyMealTicketScreen> {
  // ticket number state
  String _ticketNumber = "";
  void setTicketNumber(String value) {
    setState(() {
      _ticketNumber = value;
    });
  }

  // information
  String? _information;
  void setInformation(String? value) {
    setState(() {
      _information = value;
    });
  }

  CommandMeal _commandMeal = CommandMeal.empty();

  Future<void> verifyTicket() async {
    // TODO : put here ticket verification from API
    var commandMeal = await CommandMeal.fetchCommandMeal(_ticketNumber);
    if (commandMeal is CommandMeal) {
      setState(() {
        setInformation(null);
        _commandMeal = commandMeal;
      });
    } else {
      setState(() {
        setInformation("Ticket vide ou non acheté");
        _commandMeal = CommandMeal.empty();
      });
    }
    /* setState(() {
      _commandMeal = CommandMeal(
        // number: _ticketNumber,
        breakfast: MealDays(
            hasMer: false,
            hasJeu: false,
            hasVen: true,
            hasSam: false,
            hasDim: true),
        lunch: MealDays(
            hasMer: true,
            hasJeu: true,
            hasVen: false,
            hasSam: false,
            hasDim: false),
        dinner: MealDays(
            hasMer: true,
            hasJeu: false,
            hasVen: false,
            hasSam: true,
            hasDim: false),
      );
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Verifier ticket sakafo"),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            mainContent(context),
          ],
        ),
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(
              'Ticket n°',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: "Ex. 001A",
                      ),
                      onChanged: (value) {
                        setTicketNumber(value);
                      },
                      onFieldSubmitted: (String? value) {
                        setTicketNumber(value!);
                        verifyTicket();
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: verifyTicket,
                      icon: const Icon(
                        color: AppColors.PRIMARY,
                        CupertinoIcons.search_circle_fill,
                        size: 40,
                      ))
                ],
              ),
            ),

            // QR Scan
            // Detect button
            Container(
              margin: const EdgeInsets.only(top: 16),
              // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
              height: 48,
              child: ButtonSolid(
                "Scanner",
                onPressed: () async {
                  // TODO SCan QR
                  // print('Scanner');
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QrScreen()),
                  );
                  if (result is String) {
                    // _textController.text = result;
                    setTicketNumber(result);
                    verifyTicket();
                  }
                },
                icon: CupertinoIcons.camera,
                color: AppColors.PRIMARY,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 32),
              // Result
              child: MealTicketInfoWidget(
                  information: _information,
                  number: _ticketNumber,
                  commandMeal: _commandMeal),
            )
          ],
        ));
  }
}
