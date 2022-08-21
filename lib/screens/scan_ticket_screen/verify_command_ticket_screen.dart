// ignore_for_file: prefer_const_constructors

import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/screens/qr_screen/qr_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_ticket_screen/command_ticket_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyCommandTicketScreen extends StatefulWidget {
  // declaration
  const VerifyCommandTicketScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyCommandTicketScreenState();
}

class _VerifyCommandTicketScreenState extends State<VerifyCommandTicketScreen> {
  final _formKey = GlobalKey<FormState>();
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

  // CommandMeal _commandMeal = CommandMeal.empty();

  Future<void> verifyTicket({String? ticketNumber}) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        // CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return CommandTicketInfoScreen(
            ticketNumber: ticketNumber ?? _ticketNumber,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vérifier ticket sakafo"),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _mainContent(context),
            Container(
              alignment: Alignment.bottomLeft,
              child: BottomAppBar(
                elevation: 0,
                shape: const CircularNotchedRectangle(),
                color: AppColors.TRANSPARENT,
                child: _bottomBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Container(
        child: ListView(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.MARGIN_Y, horizontal: AppSizes.MARGIN_X),
      shrinkWrap: true,
      children: <Widget>[
        Text(
          'Ticket n°',
          style: AppTextStyle.head2(color: AppColors.PRIMARY),
        ),
        Form(
          key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrer le numéro du ticket SVP';
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    verifyTicket();
                  },
                  icon: Icon(
                    color: AppColors.PRIMARY,
                    CupertinoIcons.search_circle_fill,
                    size: 40,
                  ))
            ],
          ),
        ),
        /* Container(
          margin: const EdgeInsets.only(top: 32),
          // Result
          child: MealTicketInfoWidget(
              information: _information,
              number: _ticketNumber,
              commandMeal: _commandMeal),
        ) */
      ],
    ));
  }

  Widget _bottomBar(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: BottomAppBar(
        elevation: 0,
        // shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,

          // Scan button
          child: ButtonSolid(
            'Scanner',
            color: AppColors.PRIMARY,
            icon: CupertinoIcons.camera,
            onPressed: () async {
              // Scan SR
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
          ),
        ),
      ),
    );
  }
}
