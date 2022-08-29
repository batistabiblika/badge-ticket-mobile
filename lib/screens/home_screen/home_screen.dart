import 'package:fbb_reg_ticket/components/widgets/button_tile.dart';
import 'package:fbb_reg_ticket/model/command_ticket.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_ticket_screen/components/meal_configuration_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text("FFBBM 90e"),
        leading: IconButton(
          onPressed: () {
            // Setting
            Navigator.pushNamed(context, "/settings");
          },
          icon: Icon(CupertinoIcons.bars),
        ),
        actions: [
          IconButton(
            tooltip: "About",
            onPressed: () {
              // Setting
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("A propos"),
                  content: Text(
                    "Vérification badge et ticket 90e FFBBM",
                    style: AppTextStyle.text(),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.help_outline_rounded),
          ),
        ],
        // title: Text(widget.title),
      ),
      body: SafeArea(
        // body: SingleChildScrollView(
        child: contentWidget(context),
      ),
    );
  }

  Widget contentWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          // decoration:
          //     const BoxDecoration(color: Color.fromARGB(226, 184, 8, 8)),
          child: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.MARGIN_Y, horizontal: AppSizes.MARGIN_X),
            shrinkWrap: false,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Badge
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Badge",
                  style: AppTextStyle.head3(),
                ),
              ),
              ButtonTile("Vérifier badge",
                  icon: CupertinoIcons.person,
                  color: AppColors.PRIMARY, onPressed: () {
                Navigator.pushNamed(context, '/scan_badge');
              }),

              // Margin
              SizedBox(
                height: 32,
              ),

              // Repas
              // Vérification
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  // "Ticket (Repas, Bus, Séjour)",
                  "Ticket (Repas, Transport)",
                  style: AppTextStyle.head3(),
                ),
              ),

              MealConfigurationInfoWidget(),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 96),
                      child: ButtonTile("Configurer repas",
                          // height: 80,
                          icon: Icons.alarm,
                          isLightMode: true,
                          color: AppColors.PRIMARY, onPressed: () {
                        Navigator.pushNamed(context, '/config_meal');
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                        constraints: BoxConstraints(minHeight: 96),
                        child: ButtonTile("Information ticket",
                            // height: 80,
                            icon: CupertinoIcons.tickets,
                            color: AppColors.PRIMARY, onPressed: () {
                          Navigator.pushNamed(context, '/verify_meal_ticket');
                        })),
                  ),
                ],
              ),

              // Margin
              SizedBox(
                height: 8,
              ),
              ButtonTile("Valider ticket repas",
                  color: AppColors.SECONDARY,
                  icon: CupertinoIcons.tickets, onPressed: () {
                Navigator.pushNamed(context, '/scan_meal_ticket');
              }),

              // MealConfigurationInfoWidget(),

              /* // Margin
              SizedBox(
                height: 8,
              ),
              ButtonTile("QR Test",
                  color: AppColors.RED,
                  icon: CupertinoIcons.tickets, onPressed: () {
                Navigator.pushNamed(context, '/qr_test');
              }), */
            ],
          ),
        ),
      ],
    );
  }
}
