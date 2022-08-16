import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonSolid extends StatelessWidget {
  final String data;
  final IconData? icon;
  final double? height;
  final Color? color;
  final double? fontSize;
  final VoidCallback? onPressed;
  final bool isLightMode;
  const ButtonSolid(this.data,
      {Key? key,
      required this.onPressed,
      this.color,
      this.height,
      this.isLightMode = false,
      this.icon = CupertinoIcons.person,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ElevatedButton(
        style: isLightMode
            ? TextButton.styleFrom(
                backgroundColor: AppColors.PRIMARY_TRANSLUSCENT,
                elevation: 0,
                primary: color,
                padding: const EdgeInsets.all(0))
            : ElevatedButton.styleFrom(elevation: 0, primary: color),
        onPressed: onPressed,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                data,
                softWrap: true,
                style: TextStyle(fontSize: AppSizes.TEXT_SIZE_NORMAL),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Icon(
                    icon,
                    size: 24,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
