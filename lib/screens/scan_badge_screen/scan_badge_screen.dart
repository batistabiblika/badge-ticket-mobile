import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/screens/qr_screen/qr_screen.dart';
import 'package:fbb_reg_ticket/screens/scan_meal_screen/consume_meal_screen.dart';
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

  // final TextEditingController _textController = TextEditingController();
  void setBadgeNumber(String value) {
    setState(() {
      // _textController.text = value;
      _badgeNumber = value;
    });
  }

  void verifyBadge({String? badgeNumber}) {
    Navigator.of(context).pushReplacement(
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
        title: const Text("Vérifier badge"),
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
                child: _bottomBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scanBadgeContent(BuildContext context) {
    return Container(
        child: ListView(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.MARGIN_Y, horizontal: AppSizes.MARGIN_X),
      shrinkWrap: true,
      children: <Widget>[
        Text(
          'Saisir n° badge',
          style: AppTextStyle.text(color: AppColors.PRIMARY),
        ),
        /* TextFormField(
          autofocus: false,
          // controller: _textController,
          decoration: const InputDecoration(
            // icon: Icon(CupertinoIcons.ticket),
            // labelText: "Ticket n°",
            hintText: "Ex. 001A",
          ),
          onChanged: (String? value) {
            setBadgeNumber(value!);
          },
          onFieldSubmitted: (String? value) {
            verifyBadge(badgeNumber: value);
          },
        ), */

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextFormField(
                  autofocus: false,
                  // controller: _textController,
                  decoration: const InputDecoration(
                    // icon: Icon(CupertinoIcons.ticket),
                    // labelText: "Ticket n°",
                    hintText: "Ex. 001A",
                  ),
                  onChanged: (String? value) {
                    setBadgeNumber(value!);
                  },
                  onFieldSubmitted: (String? value) {
                    verifyBadge(badgeNumber: value);
                  },
                ),
              ),
              IconButton(
                  onPressed: verifyBadge,
                  icon: const Icon(
                    color: AppColors.PRIMARY,
                    CupertinoIcons.search_circle_fill,
                    size: 40,
                  ))
            ],
          ),
        ),

        // QR Scan
        // Detect button
        /* Container(
          margin: const EdgeInsets.only(top: 16),
          // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
          height: 48,
          child: ButtonSolid(
            "Vérifier",
            onPressed: () async {
              verifyBadge();
            },
            icon: CupertinoIcons.person,
            color: AppColors.PRIMARY,
          ),
        ), */
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
          child: ButtonSolid(
            'Scanner',
            color: AppColors.PRIMARY,
            icon: CupertinoIcons.camera,
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrScreen()),
              );
              if (result is String) {
                // _textController.text = result;
                setBadgeNumber(result);
                verifyBadge(badgeNumber: result);
              }
            },
          ),
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
