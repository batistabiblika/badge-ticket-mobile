import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  final String data;
  final IconData? icon;
  final double? height;
  final Color? color;
  final double? fontSize;
  final double? borderRadius;
  final bool isLightMode;
  final VoidCallback? onPressed;
  const ButtonTile(this.data,
      {Key? key,
      required this.onPressed,
      this.color,
      this.height,
      this.borderRadius = 8,
      this.isLightMode = false,
      this.icon = CupertinoIcons.person,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: isLightMode
          ? TextButton.styleFrom(
              backgroundColor: AppColors.PRIMARY_TRANSLUSCENT,
              elevation: 0,
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
              padding: const EdgeInsets.all(0))
          : ElevatedButton.styleFrom(
              elevation: 0,
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              ),
            ),
      onPressed: onPressed,
      child: Container(
        height: height,
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: Icon(
                icon,
                size: 32,
              ),
            ),
            Text(
              data,
              softWrap: true,
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
