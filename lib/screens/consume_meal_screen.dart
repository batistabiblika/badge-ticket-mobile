import 'package:fbb_reg_ticket/model/Command.dart';
import 'package:fbb_reg_ticket/model/command_camp.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
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
  State<StatefulWidget> createState() =>
      _ConsumeMealScreenState(ticketNumber: ticketNumber);
}

class _ConsumeMealScreenState extends State<ConsumeMealScreen> {
  String ticketNumber = "";

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

  _ConsumeMealScreenState({required this.ticketNumber});

  @override
  Widget build(BuildContext context) {
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
            _futureContent(context, ticketNumber),
            Container(
              alignment: Alignment.bottomLeft,
              child: BottomAppBar(
                elevation: 0,
                shape: const CircularNotchedRectangle(),
                color: AppColors.TRANSPARENT,
                child: bottomBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _futureContent(BuildContext context, String ticketNumber) {
    return FutureBuilder(
      future: Command.fetchCommand(Client(), ticketNumber),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occured'),
          );
        } else if (snapshot.hasData) {
          return _homeTicketContent(context, snapshot.data as Command);
        } else {
          return const Center(
            child: Text('Loading ...'),
          );
        }
      },
    );
  }

  Widget _homeTicketContent(BuildContext context, Command command) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // Ticket n%
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ticket n°',
                      style: AppTextStyle.text(color: AppColors.PRIMARY),
                    ),
                    Text(
                      command.id,
                      style: AppTextStyle.head2(color: AppColors.PRIMARY),
                    ),
                  ]),
            ),

            // Consumation date
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daty',
                      style: AppTextStyle.text(color: AppColors.PRIMARY),
                    ),
                    Text(
                      '${command.commandCamps![0].campName}',
                      style: AppTextStyle.head2(color: AppColors.PRIMARY),
                    ),
                  ]),
            ),

            // ORA (type)
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ora',
                      style: AppTextStyle.text(color: AppColors.PRIMARY),
                    ),
                    Text(
                      'Maraina',
                      style: AppTextStyle.head2(color: AppColors.PRIMARY),
                    ),
                  ]),
            ),

            // Isan'ny sakafo
            // Isan'ny sakafo GM
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Isan\'ny sakafo GM mahazo alaina',
                      style: AppTextStyle.text(color: AppColors.PRIMARY),
                    ),
                    // Achetée
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté GM achetée',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '2',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),
                    // Consommée
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté GM consommée',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '0',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),
                    // separator
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      height: 1,
                      decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
                    ),
                    // Reste disponible
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté GM disponible',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '$_maxMealGM',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),

                    // Quantité à consommer
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 4),
                      // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qté GM à consommer',
                            style: AppTextStyle.head3(color: AppColors.PRIMARY),
                          ),
                          Transform.translate(
                            offset: Offset(12, 0),
                            child: Row(
                              children: [
                                Container(
                                  height: 32,
                                  child: IconButton(
                                      iconSize: 24,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                          CupertinoIcons.minus_circle_fill),
                                      onPressed: () {
                                        _decrementConsumeMealGM();
                                      }),
                                ),
                                Container(
                                  child: Text(
                                    '$_consumeMealGM',
                                    style: AppTextStyle.head2(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(right: 0),
                                  height: 32,
                                  child: IconButton(
                                      iconSize: 24,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                          CupertinoIcons.add_circled_solid),
                                      onPressed: () {
                                        _incrementConsumeMealGM();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),

            // Isan'ny sakafo PM
            Container(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Isan\'ny sakafo PM mahazo alaina',
                      style: AppTextStyle.text(color: AppColors.PRIMARY),
                    ),
                    // Achetée
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté PM achetée',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '3',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),
                    // Consommée
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté PM consommée',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '1',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),
                    // separator
                    Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      height: 1,
                      decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
                    ),
                    // Reste disponible
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Qté PM disponible',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        ),
                        Text(
                          '$_maxMealPM',
                          style: AppTextStyle.head3(color: AppColors.PRIMARY),
                        )
                      ],
                    ),

                    // Quantité à consommer
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 4),
                      // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qté PM à consommer',
                            style: AppTextStyle.head3(color: AppColors.PRIMARY),
                          ),
                          Transform.translate(
                            offset: Offset(12, 0),
                            child: Row(
                              children: [
                                Container(
                                  height: 32,
                                  child: IconButton(
                                      iconSize: 24,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                          CupertinoIcons.minus_circle_fill),
                                      onPressed: () {
                                        _decrementConsumeMealPM();
                                      }),
                                ),
                                Container(
                                  child: Text(
                                    '$_consumeMealPM',
                                    style: AppTextStyle.head2(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(right: 0),
                                  height: 32,
                                  child: IconButton(
                                      iconSize: 24,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                          CupertinoIcons.add_circled_solid),
                                      onPressed: () {
                                        _incrementConsumeMealPM();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ));
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
                    // TODO : REPLACE IT WITH REAL DATA CHECK AND OK SCCREEN IF SUCCESS
                    Navigator.pushNamed(context, '/consume_validated');
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
