import 'package:fbb_reg_ticket/screens/scan_ticket_screen/components/consume_meal_ticket_widget.dart';
import 'package:flutter/material.dart';

class ConsumeMealScreen extends StatefulWidget {
  final String ticketNumber;
  // declaration
  const ConsumeMealScreen({Key? key, required this.ticketNumber})
      : super(key: key);
  // required param

  @override
  State<StatefulWidget> createState() => _ConsumeMealScreenState();
}

class _ConsumeMealScreenState extends State<ConsumeMealScreen> {
  String _ticketNumber = "";

  _ConsumeMealScreenState();

  @override
  Widget build(BuildContext context) {
    _ticketNumber = widget.ticketNumber;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Hisakafo"),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // _futureContent(context, _ticketNumber),
            ConsumeMealTicketWidget(
              ticketNumber: _ticketNumber,
            ),
          ],
        ),
      ),
    );
  }
}
