import 'package:dio/dio.dart';
import 'package:fbb_reg_ticket/model/badge.dart';
import 'package:fbb_reg_ticket/res/styles.dart';
import 'package:fbb_reg_ticket/res/values.dart';
import 'package:fbb_reg_ticket/screens/scan_badge_screen/components/badge_info_widget.dart';
import 'package:flutter/material.dart';

class BadgeInfoScreen extends StatefulWidget {
  final String badgeNumber;
  const BadgeInfoScreen({Key? key, required this.badgeNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BadgeInfoScreen();
}

class _BadgeInfoScreen extends State<BadgeInfoScreen> {
  String _badgeNumber = "";

  @override
  Widget build(BuildContext context) {
    // widget.badgeNumber return the badge
    _badgeNumber = widget.badgeNumber;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Information badge"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: ListView(
            shrinkWrap: true,
            // children: [BadgeInfoWidget(badge: _badge)],
            children: [
              FutureBuilder(
                  future: Badge.fetchBadge(_badgeNumber),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occured'),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data is Badge) {
                        Badge badge = snapshot.data as Badge;
                        print(badge.image);
                        return BadgeInfoWidget(badge: badge);
                      } else if (snapshot.data is String) {
                        switch (snapshot.data as String) {
                          case "NOT_FOUND":
                            return // Badge n%
                                Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: AppColors.RED,
                                      size: 80,
                                    ),
                                    Text(
                                      'Badge non-existant!',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.text(
                                          color: AppColors.PRIMARY),
                                    ),
                                    Text(
                                      'N° $_badgeNumber',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.head2(
                                          color: AppColors.RED),
                                    ),
                                  ]),
                            );
                            break;
                          default:
                            return Text(snapshot.data as String);
                        }
                      } else {
                        return Text("Error");
                      }
                    } else {
                      return const Center(
                        child: Text('Loading ...'),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
