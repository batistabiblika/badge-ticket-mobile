import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_ticket_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsumeMealValidatedScreen extends StatelessWidget {
  const ConsumeMealValidatedScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Validé"),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          // children: <Widget>[_HomeContent(), _bottomBar()],
          children: <Widget>[
            contentWidget(),
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

  // Content Widget
  Widget contentWidget() {
    return Center(
      child: Text("VAlidé avec success"),
    );
  }

  // Bottom bar
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
                    // Navigator.pushNamed(context, '/consume');
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        // CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ScanMealTicketFormScreen();
                        },
                      ),
                    );
                  },
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        const Text(
                          'Passer au suivant',
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
