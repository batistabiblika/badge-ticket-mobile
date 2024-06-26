import 'package:fbb_reg_ticket/model/command_ticket.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandTicketInfoWidget extends StatelessWidget {
  final CommandTicket commandMeal;
  final String number;
  final String? information;
  final bool? showSleeping;
  final bool? showBus;
  const CommandTicketInfoWidget({
    Key? key,
    required this.number,
    required this.commandMeal,
    this.information,
    this.showSleeping = true,
    this.showBus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? size;
    if (commandMeal.size != null) {
      if (commandMeal.size == "DAILY_KID" ||
          commandMeal.size == "ALL_TIME_KID") {
        size = "Ticket Ankizy";
      } else {
        size = "Ticket Lehibe";
      }
    }

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
              style: AppTextStyle.text(),
            ),
            Text(
              number,
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            const SizedBox(
              height: 8,
            ),
            if (information != null && information != "")
              if (information == "KO" || information == "NOT_FOUND")
                Text(
                  'Ticket not found',
                  style: AppTextStyle.head2(color: Colors.red),
                )
              else
                Text(
                  information!,
                  style: AppTextStyle.head2(color: Colors.red),
                )
            else
              const SizedBox(
                width: 0,
              ),
          ]),
        ),
        Divider(
          color: AppColors.BORDER,
          thickness: 1,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'Repas :',
          style: AppTextStyle.head3(color: AppColors.PRIMARY),
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
        ),

        if (size != null)
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              size,
              style: AppTextStyle.head3(),
            ),
          ),

        if (showSleeping != null && showSleeping!)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 24,
              ),
              /* Divider(
                color: AppColors.PRIMARY,
              ), */
              Text(
                'Hébergement :',
                style: AppTextStyle.head3(color: AppColors.PRIMARY),
              ),
              Table(
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
                    const Text("Jour"),
                    enabled(commandMeal.sleeping.hasMer),
                    enabled(commandMeal.sleeping.hasJeu),
                    enabled(commandMeal.sleeping.hasVen),
                    enabled(commandMeal.sleeping.hasSam),
                    enabled(commandMeal.sleeping.hasDim),
                  ]),
                ],
              ),
            ],
          ),

        if (showBus != null && showBus! && commandMeal.bus != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 24,
              ),
              /* Divider(
                color: AppColors.PRIMARY,
              ), */
              Text(
                'Transport :',
                style: AppTextStyle.head3(color: AppColors.PRIMARY),
              ),
              Table(
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
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      // height: 32,
                      child: const Text("Ligne"),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(commandMeal.bus!.mer,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(commandMeal.bus!.jeu,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(commandMeal.bus!.ven,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(commandMeal.bus!.sam,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(commandMeal.bus!.dim,
                          textAlign: TextAlign.center),
                    ),
                  ]),
                ],
              ),
            ],
          ),
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
