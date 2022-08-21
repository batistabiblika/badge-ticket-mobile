// ignore_for_file: prefer_const_constructors

import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/screens/qr_screen/qr_screen.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_badge_screen/badge_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyBadgeScreen extends StatefulWidget {
  // declaration
  const VerifyBadgeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerifyBadgeScreenState();
}

class _VerifyBadgeScreenState extends State<VerifyBadgeScreen> {
  final _formKey = GlobalKey<FormState>();

  // badge number state
  String _badgeNumber = "";

  // final TextEditingController _textController = TextEditingController();
  void setBadgeNumber(String value) {
    setState(() {
      // _textController.text = value;
      _badgeNumber = value;
    });
  }

  // Navigate to verivy page screen
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
          'Saisir n° badge',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Entrer le numéro du badge SVP';
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
                    verifyBadge();
                  },
                  icon: Icon(
                    color: AppColors.PRIMARY,
                    CupertinoIcons.search_circle_fill,
                    size: 40,
                  ))
            ],
          ),
        ),
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
}
