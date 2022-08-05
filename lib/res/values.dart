import 'package:flutter/material.dart';

class AppColors {
  // COLORS
  // static var PRIMARY = Colors.white;
  static const Color PRIMARY = Color(0xFF374355);
  static const Color PRIMARY_TRANSLUSCENT = Color(0x22374355);
  static const Color PRIMARY5 = Color(0x0D374355);
  static const Color PRIMARY30 = Color(0x4D374355);
  static const Color PRIMARY70 = Color(0xB2374355);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color DARK = Color(0xFF35343A);
  // Field and forms colors
  static const Color FIELD_BG_LIGHT = Color(0xFFEAEAEE);
  static const Color FIELD_FG_LIGHT = Color(0x8035343A);
  static const Color FIELD_BORDER_FOCUS_LIGHT = DARK;
  // Text colors
  static const Color TEXT_DARK = Color(0xFF35343A);
  static const Color TEXT_GRAY = Color(0xFF6D6B74);
  static const Color TEXT_ACCENT = Color(0xFF374355);
  // Buttons colors
  static const Color BTN_BG_LIGHT = Color(0xFFEAEAEE);
  static const Color BTN_FG_LIGHT = DARK;
  static const Color BTN_BG_DARK = DARK;
  static const Color BTN_FG_DARK = WHITE;
  static const Color TRANSPARENT = Color(0x00000000);
  static const Color TRANSPARENT_WHITE = Color(0xAAFFFFFF);

  // COLOR SCHEME
  static const Color RED = Color(0xFFE61D54);
  static const Color RED_TRANSLUSCENT = Color(0x22E61D54);
  // static Color BG_WHITE = Colors.grey[50];
  // static Color BTN_WHITE = Colors.grey[100];
  // static Color TEXT_GRAY= Colors.grey[600];
  // String CSS Colors value for text rendering
  static var TEXT_BLACK_CSS = '#202020';

  static const double OPACITY_ACTIVE = 1;
  static const double OPACITY_INACTIVE = 0.5;
}

class AppSizes {
  static const double MARGIN_X = 16;
  static const double MARGIN_Y = 16;
  static const double BOTTOM_BAR_SIZE_NORMAL = 56;
  static const double BOTTOM_BAR_SIZE_LARGE = 64;
  static const double TEXT_SIZE_NORMAL = 16;
  static const double TEXT_SIZE_LARGE = 18;
  static const double TEXT_SIZE_XLARGE = 22;

  // Fields
  static const double FIELD_HEIGHT = 48;
  static const double FIELD_BORDER_RADIUS = 12;

  // Fonts size
  static const double H2 = 24;
  static const double H3 = 20;
  static const double H4 = 18;
  static const double H5 = 16;
  static const double FS_TEXT = 16;
  static const double FS_TEXT_SMALL = 14;
  static const double FS_BTN_TEXT = 14;

  // slides
  static const double SLIDE_HEIGHT = 200;
  static const double SLIDE_WIDTH = 240;
  static const double SLIDE_BORDER_RADIUS = 16;
}
