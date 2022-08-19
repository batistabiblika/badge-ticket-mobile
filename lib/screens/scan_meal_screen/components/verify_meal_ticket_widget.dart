import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/model/command_meal.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/components/meal_ticket_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsumeMealTicketWidget extends StatefulWidget {
  final String ticketNumber;
  // declaration
  const ConsumeMealTicketWidget({Key? key, required this.ticketNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConsumeMealTicketWidgetState();
}

class _ConsumeMealTicketWidgetState extends State<ConsumeMealTicketWidget> {
  // ticket number state
  String _ticketNumber = "";
  CommandMeal _commandMeal = CommandMeal.empty();
  // information
  String? _information = "";

  void newScan() {
    Navigator.pushReplacementNamed(context, '/scan_meal_ticket');
  }

  void consumeMeal() async {
    var result = await CommandMeal.consumeCommandMeal(_ticketNumber);
    print(result);
    switch (result) {
      case "VALIDATED":
        Navigator.pushReplacementNamed(context, '/consume_validated');
        break;
      case "CONSUMED":
        Navigator.pushReplacementNamed(context, '/consume_consumed');
        break;
      case "NOT_FOUND":
        Navigator.pushReplacementNamed(context, '/consume_not_found');
        break;
      case "INVALID":
        Navigator.pushReplacementNamed(context, '/consume_invalid');
        break;
      case "ERROR":
        break;
      default:
        Navigator.pushReplacementNamed(context, '/consume_refused');
    }
  }

  @override
  Widget build(BuildContext context) {
    _ticketNumber = widget.ticketNumber;
    return Container(
      child: FutureBuilder(
        // future: verifyTicket(),
        future: CommandMeal.fetchCommandMeal(_ticketNumber),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('An error has occured'));
          } else {
            if (snapshot.hasData) {
              if (snapshot.data is CommandMeal) {
                var commandMeal = snapshot.data as CommandMeal;
                return _mealTicket(commandMeal);
              } else if (snapshot.data is String) {
                /* return Text(
                  'Message : ${snapshot.data}, Ticket $_ticketNumber',
                  style: AppTextStyle.head2(color: AppColors.PRIMARY),
                ); */

                return _error(snapshot.data as String, _ticketNumber);
              } else {
                return _error('An error occured', _ticketNumber);
              }
            } else {
              return _loading();
            }
          }
        },
      ),
    );
  }

  Widget _mealTicket(CommandMeal commandMeal) {
    return ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: <Widget>[
        Text(
          'Ticket n° $_ticketNumber',
          style: AppTextStyle.head2(color: AppColors.PRIMARY),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          // Result
          child: MealTicketInfoWidget(
              information: _information,
              number: _ticketNumber,
              commandMeal: commandMeal),
        ),
        const SizedBox(
          height: 16,
        ),
        ButtonSolid(
          "Valider ticket",
          icon: CupertinoIcons.checkmark_seal,
          color: AppColors.PRIMARY,
          onPressed: () {
            consumeMeal();
          },
        ),
      ],
    );
  }

  Widget _error(String message, String? ticketNumber) {
    Widget result = Text('Error message $message');
    switch (message) {
      case "NOT_FOUND":
        result = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Le ticket n°$ticketNumber n\'existe pas',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Veuillez saisir ou scanner à nouveau le numéro de ticket',
              style: AppTextStyle.text(),
            )
          ],
        );
        break;
      case "NO_ROUTE_FOUND":
        result = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket non trouvé',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Veuillez saisir ou scanner à nouveau le numéro de ticket',
              style: AppTextStyle.text(),
            )
          ],
        );
        break;
      default:
    }
    return ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: <Widget>[
          result,
          const SizedBox(
            height: 16,
          ),
          ButtonSolid(
            "Scanner à nouveau",
            icon: CupertinoIcons.camera,
            color: AppColors.PRIMARY,
            onPressed: () {
              newScan();
            },
          ),
        ]);
  }

  Widget _loading() {
    return ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(
            height: 100,
            child: Center(
              child: Text("Chargement ..."),
            ),
          ),
          ButtonSolid(
            "Scanner à nouveau",
            icon: CupertinoIcons.camera,
            color: AppColors.PRIMARY,
            onPressed: () {
              newScan();
            },
          ),
        ]);
  }
}
