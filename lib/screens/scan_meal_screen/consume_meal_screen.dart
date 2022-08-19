import 'package:fbb_reg_ticket/model/Command.dart';
import 'package:fbb_reg_ticket/model/command_camp.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/components/verify_meal_ticket_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  CommandCamp? _commandCamp;
  // todo : load it from API
  int _maxMealGM = 10;
  int _maxMealPM = 10;
  int _consumeMealGM = 0; // todo get it from maxmeal
  int _consumeMealPM = 0;
  void _incrementConsumeMealGM() {
    setState(() {
      _consumeMealGM < _maxMealGM ? _consumeMealGM++ : _maxMealGM;
    });
  }

  void _decrementConsumeMealGM() {
    setState(() {
      _consumeMealGM > 0 ? _consumeMealGM-- : 0;
    });
  }

  void _incrementConsumeMealPM() {
    setState(() {
      _consumeMealPM < _maxMealPM ? _consumeMealPM++ : _maxMealPM;
    });
  }

  void _decrementConsumeMealPM() {
    setState(() {
      _consumeMealPM > 0 ? _consumeMealPM-- : 0;
    });
  }

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
          // children: <Widget>[_HomeContent(), _bottomBar()],
          children: <Widget>[
            // _futureContent(context, _ticketNumber),
            ConsumeMealTicketWidget(
              ticketNumber: _ticketNumber,
            ),
            /* Container(
              alignment: Alignment.bottomLeft,
              child: BottomAppBar(
                elevation: 0,
                shape: const CircularNotchedRectangle(),
                color: AppColors.TRANSPARENT,
                child: bottomBar(context),
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 48,
                margin: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: AppColors.PRIMARY),
                  onPressed: () {
                    // TODO : REPLACE IT WITH REAL DATA CHECK AND OK SCREEN IF SUCCESS
                    Navigator.pushReplacementNamed(
                        context, '/consume_validated');
                    // Navigator.pushNamed(context, '/consume_refused');
                  },
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        const Text(
                          'Valider',
                          style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Icon(
                              CupertinoIcons.checkmark_seal,
                              size: 24,
                            ))
                      ])),
                ),
              ),
            ]));
  }
}
