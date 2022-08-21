import 'package:fbb_reg_ticket/components/widgets/button_solid.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigureMealTicketScreen extends StatefulWidget {
  const ConfigureMealTicketScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigureMealTicketScreen();
}

class _ConfigureMealTicketScreen extends State<ConfigureMealTicketScreen> {
  // meal day state
  String _mealDay = "MER";
  void setMealDay(String value) {
    setState(() {
      _mealDay = value;
    });
  }

  // meal type state
  String _mealType = "BREAKFAST";
  void setMealType(String value) {
    setState(() {
      _mealType = value;
    });
  }

  /* void selectMealDay() {
    print("Select meal day screen");
  }

  void selectMealType() {
    print("Select meal day screen");
  } */

  // shared preference
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> saveSetting() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('mealDay', _mealDay);
    await prefs.setString('mealType', _mealType);
  }

  Future<void> loadSetting() async {
    print("Loading meal setting");
    final SharedPreferences prefs = await _prefs;
    String mealDay = prefs.getString('mealDay') ?? AppSettings.MEAL_DAY;
    setMealDay(mealDay);
    String mealType = prefs.getString('mealType') ?? AppSettings.MEAL_TYPE;
    setMealType(mealType);
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
                child: _bottomBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget configureMealContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shrinkWrap: true,
      children: [
        // Date du repas
        Text(
          'Jour du repas',
          style: AppTextStyle.text(color: AppColors.PRIMARY),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 4),
          // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
          // height: 48,
          child: DropdownButton(
            isExpanded: true,
            alignment: AlignmentDirectional.topStart,
            style: AppTextStyle.head3(color: AppColors.PRIMARY),
            itemHeight: 48,
            value: _mealDay,
            onChanged: (String? value) {
              setMealDay(value!);
            },
            items: const [
              DropdownMenuItem(value: "MER", child: Text("Mercredi")),
              DropdownMenuItem(value: "JEU", child: Text("Jeudi")),
              DropdownMenuItem(value: "VEN", child: Text("Vendredi")),
              DropdownMenuItem(value: "SAM", child: Text("Samedi")),
              DropdownMenuItem(value: "DIM", child: Text("Dimanche")),
            ],
          ),
        ),

        // Type du repas
        Text(
          'Heure du repas',
          style: AppTextStyle.text(color: AppColors.PRIMARY),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 4),
          // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
          // height: 48,
          child: DropdownButton(
            isExpanded: true,
            alignment: AlignmentDirectional.topStart,
            style: AppTextStyle.head3(color: AppColors.PRIMARY),
            itemHeight: 48,
            value: _mealType,
            onChanged: (String? value) {
              setMealType(value!);
            },
            items: const [
              DropdownMenuItem(
                  value: "BREAKFAST", child: Text("Petit déjeuner (Maraina)")),
              DropdownMenuItem(
                  value: "LUNCH", child: Text("Déjeuner (Atoandro)")),
              DropdownMenuItem(value: "DINNER", child: Text("Dinner (Hariva)")),
            ],
          ),
        ),

        // Detect button
        /* Container(
          margin: const EdgeInsets.only(top: 16),
          // decoration: BoxDecoration(color: AppColors.BTN_BG_LIGHT),
          height: 40,
          child: TextButton(
            onPressed: () {
              print('Auto detect');
            },
            child: Text('Detecter auto.'),
            style: TextButton.styleFrom(
                backgroundColor: AppColors.PRIMARY_TRANSLUSCENT,
                elevation: 0,
                primary: AppColors.PRIMARY),
          ),
        ), */
      ],
    );
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
            'Enregistrer config. repas',
            color: AppColors.PRIMARY,
            icon: CupertinoIcons.square_arrow_down,
            onPressed: () {
              saveSetting();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ),
      ),
    );
  }
}
