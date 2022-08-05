import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyBusTicketScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _VerifyBusTicketScreenState extends State<VerifyBusTicketScreen> {
  String ticketNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Verifier ticket Bus"),
        ),
        body: SafeArea(
          child: verifyBusTicketContent(context, ticketNumber),
        ));
  }

  Widget verifyBusTicketContent(BuildContext context, String ticketNumber) {
    // return FutureBuilder(builder: builder)
    return Text("Cool");
  }
}
