import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealConfigurationInfoWidget extends StatefulWidget {
  const MealConfigurationInfoWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MealConfigurationInfoWidgetState();
}

class _MealConfigurationInfoWidgetState
    extends State<MealConfigurationInfoWidget> {
  Future<String> getMealConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String mealDay = prefs.getString('mealDay') ?? AppSettings.MEAL_DAY;
    String mealType = prefs.getString('mealType') ?? AppSettings.MEAL_TYPE;
    switch (mealType.toUpperCase()) {
      case "BREAKFAST":
        // mealType = "Petit déjeuner";
        mealType = "Sakafo maraina";
        break;
      case "LUNCH":
        // mealType = "Déjeuner";
        mealType = "Sakafo atoandro";
        break;
      case "DINNER":
        // mealType = "Dinner";
        mealType = "Sakafo hariva";
        break;
    }
    switch (mealDay.toUpperCase()) {
      case "MER":
        // mealDay = "Mercredi";
        mealDay = "Alarobia";
        break;
      case "JEU":
        // mealDay = "Jeudi";
        mealDay = "Alakamisy";
        break;
      case "VEN":
        // mealDay = "Vendredi";
        mealDay = "Zoma";
        break;
      case "SAM":
        // mealDay = "Samedi";
        mealDay = "Sabotsy";
        break;
      case "DIM":
        // mealDay = "Dimanche";
        mealDay = "Alahady";
        break;
    }
    return ('${mealType}n\'ny $mealDay');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.BORDER),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            "Repas concerné :",
            style: AppTextStyle.text(),
            textAlign: TextAlign.center,
          ),
          FutureBuilder(
            future: getMealConfig(),
            builder: ((context, snapshot) {
              if (snapshot.hasData && snapshot.data is String) {
                return Text(
                  snapshot.data as String,
                  style: AppTextStyle.text(),
                  textAlign: TextAlign.center,
                );
              }
              return SizedBox();
            }),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
