import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  // host address state
  // String _host = "192.168.1.1:3000";
  String _host = AppSettings.HOST;
  void setHost(String value) {
    setState(() {
      _host = value;
    });
  }

  bool _flash = AppSettings.FLASH;
  void setFlash(bool value) {
    setState(() {
      _flash = value;
    });
  }

  // shared preference
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> saveSetting() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('host', _host);
    await prefs.setBool('flash', _flash);
  }

  Future<void> loadSetting() async {
    // print("Loading setting");
    final SharedPreferences prefs = await _prefs;
    String host = prefs.getString('host') ?? AppSettings.HOST;
    setHost(host);
    bool flash = prefs.getBool('flash') ?? AppSettings.FLASH;
    setFlash(flash);
  }

  @override
  void initState() {
    super.initState();
    loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Configuration repas"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            configureMealContent(context),
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

  Widget configureMealContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.MARGIN_Y, horizontal: AppSizes.MARGIN_X),
      shrinkWrap: true,
      children: [
        // Date du repas
        Text(
          'Adresse web ou IP et port du serveur :',
          style: AppTextStyle.text(color: AppColors.PRIMARY),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Container(
            height: 48,
            child: TextButton(
              child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text(
                      _host,
                      textAlign: TextAlign.left,
                      style:
                          const TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: const Icon(
                          Icons.create,
                          size: 24,
                        ))
                  ])),
              onPressed: () {
                _displayHostDialog(context);
              },
            ),
          ),
        ),
        const Divider(color: AppColors.PRIMARY),
        Container(
            height: 48,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Flash du scan (appareil photo)",
                  style: AppTextStyle.text(color: AppColors.PRIMARY),
                ),
                Switch(
                    value: _flash,
                    activeColor: AppColors.GREEN,
                    onChanged: (value) {
                      setFlash(value);
                    })
              ],
            ))
      ],
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
                saveSetting();

                Navigator.of(context).pop();
              },
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Enregistrer',
                      style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: const Icon(
                        CupertinoIcons.square_arrow_down,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _displayHostDialog(BuildContext context) async {
    String host = _host;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Adresse Web/IP et port du serveur '),
            content: TextFormField(
              initialValue: host,
              onChanged: (String value) {
                setState(() {
                  host = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Text"),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setHost(host);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
