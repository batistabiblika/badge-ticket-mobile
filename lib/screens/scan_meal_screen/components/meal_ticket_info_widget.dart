import 'package:fbb_reg_ticket/model/badge.dart';
import 'package:fbb_reg_ticket/model/command_meal.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealTicketInfoWidget extends StatelessWidget {
  final CommandMeal commandMeal;
  final String number;
  final String? information;
  const MealTicketInfoWidget(
      {Key? key,
      required this.number,
      required this.commandMeal,
      this.information})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Ticket n%
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Information à propos du ticket n°',
              style: AppTextStyle.text(color: AppColors.PRIMARY),
            ),
            Text(
              number,
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            const SizedBox(
              height: 8,
            ),
            (information != null)
                ? Text(
                    information!,
                    style: AppTextStyle.head2(color: Colors.red),
                  )
                : const SizedBox(
                    width: 0,
                  ),
          ]),
        ),

        Table(
          // border: TableBorder.all(color: AppColors.PRIMARY),
          /* border: TableBorder.lerp(
              TableBorder(bottom: BorderSide(color: AppColors.PRIMARY)),
              TableBorder(bottom: BorderSide(color: AppColors.SECONDARY)),
              0.2), */
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder(
              horizontalInside: BorderSide(color: AppColors.PRIMARY)),
          children: [
            const TableRow(children: [
              SizedBox(
                height: 32,
              ),
              Text("Merc", textAlign: TextAlign.center),
              Text("Jeu", textAlign: TextAlign.center),
              Text("Ven", textAlign: TextAlign.center),
              Text("Sam", textAlign: TextAlign.center),
              Text("Dim", textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              const Text("Matin"),
              enabled(commandMeal.breakfast.hasMer),
              enabled(commandMeal.breakfast.hasJeu),
              enabled(commandMeal.breakfast.hasVen),
              enabled(commandMeal.breakfast.hasSam),
              enabled(commandMeal.breakfast.hasDim),
            ]),
            TableRow(children: [
              const Text("Midi"),
              enabled(commandMeal.lunch.hasMer),
              enabled(commandMeal.lunch.hasJeu),
              enabled(commandMeal.lunch.hasVen),
              enabled(commandMeal.lunch.hasSam),
              enabled(commandMeal.lunch.hasDim),
            ]),
            TableRow(children: [
              const Text("Soir"),
              enabled(commandMeal.dinner.hasMer),
              enabled(commandMeal.dinner.hasJeu),
              enabled(commandMeal.dinner.hasVen),
              enabled(commandMeal.dinner.hasSam),
              enabled(commandMeal.dinner.hasDim),
            ]),
          ],
        )
      ],
    );
  }

  Widget enabled(bool isEnabled) {
    return Container(
      height: 32,
      child: isEnabled
          ? const Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              color: AppColors.SECONDARY,
            )
          : const Text(""),
    );
  }
}
