import 'package:fbb_reg_ticket/res/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static title({color: AppColors.TEXT_DARK, fontWeight: FontWeight.bold}) {
    return TextStyle(color: color, fontSize: AppSizes.H2, fontWeight: fontWeight
        // color: AppColors.DARK
        );
  }

  static text({color: AppColors.TEXT_DARK, fontWeight: FontWeight.normal}) {
    return TextStyle(
        color: color,
        fontSize: AppSizes.FS_TEXT,
        fontWeight: fontWeight,
        height: 1.7
        // color: AppColors.DARK
        );
  }

  static head2({color: AppColors.TEXT_DARK, fontWeight: FontWeight.bold}) {
    return TextStyle(color: color, fontSize: AppSizes.H3, fontWeight: fontWeight
        // color: AppColors.DARK
        );
  }

  static head3({color: AppColors.TEXT_DARK, fontWeight: FontWeight.bold}) {
    return TextStyle(color: color, fontSize: AppSizes.H4, fontWeight: fontWeight
        // color: AppColors.DARK
        );
  }

  static head4({color: AppColors.TEXT_GRAY, fontWeight: FontWeight.normal}) {
    return TextStyle(
        color: color, fontSize: AppSizes.H5, fontWeight: fontWeight, height: 1.7
        // color: AppColors.DARK
        );
  }
}

class AppInputDecoration {
  static textField1({hint: 'Hint...', prefixIcon, label}) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      hintStyle: TextStyle(color: AppColors.FIELD_FG_LIGHT),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: AppColors.FIELD_BG_LIGHT,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.FIELD_BORDER_RADIUS),
          borderSide: BorderSide(color: AppColors.FIELD_BG_LIGHT)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.FIELD_BORDER_FOCUS_LIGHT),
          borderRadius: BorderRadius.circular(AppSizes.FIELD_BORDER_RADIUS)),
    );
  }
}

class AppButtonStyle {
  // text button styles
  static textButtonStyle1() {
    return TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 0),
        primary: AppColors.TEXT_GRAY,
        textStyle: TextStyle(
            fontSize: AppSizes.FS_BTN_TEXT, fontWeight: FontWeight.w500));
  }

  // elevated buttons styles
  static elevatedButtonStyle1() {
    return ElevatedButton.styleFrom(
      onPrimary: AppColors.BTN_FG_LIGHT,
      primary: AppColors.BTN_BG_LIGHT,
      elevation: 0,
      textStyle: TextStyle(
          fontSize: AppSizes.FS_BTN_TEXT, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          // Radius.circular(8.0),
          Radius.circular(24.0),
        ),
      ),
    );
  }

  static elevatedButtonStyle2() {
    return ElevatedButton.styleFrom(
      onPrimary: AppColors.BTN_FG_DARK,
      primary: AppColors.BTN_BG_DARK,
      elevation: 2,
      textStyle: TextStyle(
          fontSize: AppSizes.FS_BTN_TEXT, fontWeight: FontWeight.w400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
          // Radius.circular(24.0),
        ),
      ),
    );
    /* return ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(AppColors.BTN_FG_DARK),
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.BTN_BG_DARK),
      elevation: MaterialStateProperty.all<double>(2),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: AppSizes.FS_BTN_TEXT,
          fontWeight: FontWeight.w400,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    ); */
  }
}
