import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/scan_meal_ticket_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsumeMealValidatedScreen extends StatelessWidget {
  final bool isSuccess;
  final String? message;
  const ConsumeMealValidatedScreen(
      {Key? key, required this.isSuccess, this.message})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(isSuccess ? "Validé" : "Erreur validation"),
        // title: Text(widget.title),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: Stack(
          // children: <Widget>[_HomeContent(), _bottomBar()],
          children: <Widget>[
            contentWidget(isSuccess),
            Container(
              alignment: Alignment.bottomLeft,
              child: BottomAppBar(
                elevation: 0,
                shape: const CircularNotchedRectangle(),
                color: AppColors.TRANSPARENT,
                child: bottomBar(context, isSuccess),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Content Widget
  Widget contentWidget(bool isSuccess) {
    Widget successWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            CupertinoIcons.checkmark_circle_fill,
            size: 96,
            color: Colors.green,
          ),
          Text("Ticket validé et consommé avec success", softWrap: true),
        ]);
    Widget failedWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Erreur lors de la validation du ticket",
            style: AppTextStyle.text(color: Colors.red),
          ),
          SizedBox(
            height: 24,
          ),
          const Icon(
            CupertinoIcons.clear_circled_solid,
            size: 96,
            color: Colors.red,
          ),
          SizedBox(
            height: 24,
          ),
          if (message == "NOT_FOUND")
            Text(
              "Numéro du ticket innexistant",
              style: AppTextStyle.text(),
            ),
          if (message == "CONSUMED")
            Text(
              "Repas déja consommé",
              style: AppTextStyle.text(),
            ),
          if (message == "INVALID")
            Text("Configuration du repas invalide ou ticket non acheté",
                style: AppTextStyle.text()),
          if (message == "REFUSED") const Text("REFUSED"),
        ]);

    Widget renderedWidget = failedWidget;
    if (isSuccess) {
      renderedWidget = successWidget;
    }
    return Center(
      heightFactor: 0.9,
      child: renderedWidget,
    );
  }

  // Bottom bar
  Widget bottomBar(BuildContext context, bool isSuccess) {
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        // CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ScanMealTicketScreen();
                        },
                      ),
                    );
                  },
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Text(
                          isSuccess ? 'Passer au suivant' : 'Revenir',
                          style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Icon(
                              isSuccess
                                  ? CupertinoIcons.arrow_right
                                  : CupertinoIcons.arrow_left,
                              size: 24,
                            ))
                      ])),
                ),
              ),
            ]));
  }
}
