import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/screens/consume_meal_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_badge_screen/badge_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanBadgeScreen extends StatefulWidget {
  // declaration
  const ScanBadgeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanBadgeScreenState();
}

class _ScanBadgeScreenState extends State<ScanBadgeScreen> {
  String _badgeNumber = "";
  void changeBadgeNumber(String value) {
    setState(() {
      _badgeNumber = value;
    });
  }

  void verifyBadge({String? badgeNumber}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // CupertinoPageRoute<void>(
        builder: (BuildContext context) {
          return BadgeInfoScreen(
            badgeNumber: badgeNumber ?? _badgeNumber,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Scanner badge"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            scanBadgeContent(context),
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

  Widget scanBadgeContent(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(
              'Badge n°',
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
                changeBadgeNumber(value!);
              },
              onFieldSubmitted: (String? value) {
                verifyBadge(badgeNumber: value);
              },
            ),

            // QR Scan
            // Detect button
            Container(
              margin: const EdgeInsets.only(top: 16),
              // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
              height: 48,
              child: ButtonSolid(
                "Scanner",
                onPressed: () {
                  // TODO SCan QR
                  print('Scanner');
                },
                icon: CupertinoIcons.camera,
                color: AppColors.PRIMARY,
              ),
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
                // Navigator.pushNamed(context, '/consume');
                verifyBadge();
              },
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
                          CupertinoIcons.person,
                          size: 24,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
