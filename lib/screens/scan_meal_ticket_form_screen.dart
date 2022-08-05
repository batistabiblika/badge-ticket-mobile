import 'package:fbb_reg_ticket/screens/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanMealTicketFormScreen extends StatefulWidget {
  // declaration
  const ScanMealTicketFormScreen({Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanMealTicketFormScreenState();
}

class _ScanMealTicketFormScreenState extends State<ScanMealTicketFormScreen> {
  String _ticketNumber = "";
  void changeTicketNumber(String value) {
    setState(() {
      _ticketNumber = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Scanner ticket sakafo"),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          // children: <Widget>[_HomeContent(), _bottomBar()],
          children: <Widget>[
            homeTicketContent(context),
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

  Widget homeTicketContent(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(
              'Ticket n°',
              style: AppTextStyle.head2(color: AppColors.PRIMARY),
            ),
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                // icon: Icon(CupertinoIcons.ticket),
                // labelText: "Ticket n°",
                hintText: "Ex. 001A",
              ),
              onChanged: (String? value) {
                changeTicketNumber(value!);
              },
            )
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
              SizedBox(
                height: 48,
                // margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.PRIMARY_TRANSLUSCENT,
                      elevation: 0,
                      primary: AppColors.PRIMARY,
                      padding: const EdgeInsets.all(0)),
                  onPressed: () {},
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        const Text(
                          'Vérifier',
                          style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Icon(
                              CupertinoIcons.info,
                              size: 24,
                            ))
                      ])),
                ),
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: AppColors.PRIMARY),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/consume');
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        // CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                          return ConsumeMealScreen(
                            ticketNumber: _ticketNumber,
                          );
                        },
                      ),
                    );
                  },
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        const Text(
                          'Hisakafo',
                          style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Icon(
                              CupertinoIcons.tickets,
                              size: 24,
                            ))
                      ])),
                ),
              ),
            ]));
  }
}
