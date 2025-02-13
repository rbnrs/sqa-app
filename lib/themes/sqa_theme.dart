import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';

class SqaTheme {
  static Color primaryColor = const Color(0xff61d69b);
  static Color secondaryColor = const Color(0xff2e4350);
  static Color backgroundColor = const Color(0xff101d25);
  static Color fontColor = const Color(0xffffffff);
  static Color subFontColor = const Color(0xFFADADAD);
  static Color shadowColor = const Color(0xff696969);

  static const fontFamily = 'BebasNeue';

  static ProgressIndicatorThemeData createProgressIndicatorTheme() {
    return ProgressIndicatorThemeData(
      linearTrackColor: secondaryColor,
      color: primaryColor,
    );
  }

  static AppBarTheme createAppbarTheme() {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
      foregroundColor: fontColor,
      shadowColor: shadowColor,
    );
  }

  static IconButtonThemeData createIconButtonTheme() {
    return IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }

        return fontColor;
      })),
    );
  }

  static TextButtonThemeData createTextButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          SqaTheme.primaryColor,
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData createFloatingActionButtonTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static ElevatedButtonThemeData createElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          primaryColor,
        ),
        foregroundColor: WidgetStatePropertyAll(secondaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  static FilledButtonThemeData createFilledButtonTheme() {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          secondaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  static SearchBarThemeData createSearchbarTheme() {
    return SearchBarThemeData(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      surfaceTintColor: const WidgetStatePropertyAll(
        Colors.transparent,
      ),
      elevation: const WidgetStatePropertyAll(0),
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: secondaryColor,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: secondaryColor,
          ),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          color: fontColor,
        ),
      ),
      overlayColor: WidgetStatePropertyAll(
        primaryColor,
      ),
    );
  }

  static InputDecorationTheme createInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: SqaTheme.secondaryColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: SqaTheme.primaryColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusColor: SqaTheme.fontColor,
    );
  }

  static DropdownMenuThemeData createDropDownMenuTheme() {
    return DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: fontColor,
              )),
        ),
      ),
      inputDecorationTheme: SqaTheme.createInputDecorationTheme(),
    );
  }

  static OutlinedButtonThemeData createOutlineButtonTheme() {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: fontColor)),
        ),
      ),
    );
  }

  static SliderThemeData createSliderTheme() {
    return SliderThemeData(
      thumbColor: primaryColor,
      activeTrackColor: primaryColor,
      valueIndicatorColor: Colors.white,
      valueIndicatorTextStyle: TextStyle(
        color: backgroundColor,
      ),
    );
  }

  static DatePickerThemeData createDatePickerTheme() {
    return DatePickerThemeData(
        backgroundColor: backgroundColor,
        headerForegroundColor: fontColor,
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return null;
        }),
        yearForegroundColor: WidgetStatePropertyAll(fontColor),
        //  todayBackgroundColor: WidgetStatePropertyAll(secondaryColor),
        todayBorder: BorderSide(color: secondaryColor),
        todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }

          return null;
        }),
        todayForegroundColor: WidgetStatePropertyAll(fontColor),
        dayForegroundColor: WidgetStatePropertyAll(fontColor),
        dayOverlayColor: WidgetStatePropertyAll(primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ));
  }

  static TimePickerThemeData createTimePickerTheme() {
    return TimePickerThemeData(
        backgroundColor: backgroundColor,
        dayPeriodColor: secondaryColor,
        hourMinuteColor: secondaryColor,
        hourMinuteTextColor: fontColor,
        dialHandColor: primaryColor,
        dialBackgroundColor: secondaryColor,
        dialTextColor: fontColor,
        dayPeriodTextColor: fontColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ));
  }

  static BottomAppBarTheme createBottomAppBar() {
    return BottomAppBarTheme(
      color: backgroundColor,
    );
  }

  static DialogTheme createDialogTheme() {
    return DialogTheme(
        backgroundColor: SqaTheme.backgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ));
  }

  static TextTheme createTextTheme() {
    return TextTheme(
      bodyLarge:
          TextStyle(fontFamily: fontFamily, fontSize: 20, color: fontColor),
      bodyMedium:
          TextStyle(fontFamily: fontFamily, fontSize: 18, color: fontColor),
      bodySmall:
          TextStyle(fontFamily: fontFamily, fontSize: 16, color: fontColor),
      displayLarge:
          TextStyle(fontFamily: fontFamily, fontSize: 45, color: fontColor),
      displayMedium:
          TextStyle(fontFamily: fontFamily, fontSize: 35, color: fontColor),
      displaySmall:
          TextStyle(fontFamily: fontFamily, fontSize: 25, color: fontColor),
      headlineLarge:
          TextStyle(fontFamily: fontFamily, fontSize: 25, color: fontColor),
      headlineMedium:
          TextStyle(fontFamily: fontFamily, fontSize: 22, color: fontColor),
      headlineSmall:
          TextStyle(fontFamily: fontFamily, fontSize: 20, color: fontColor),
      labelLarge:
          TextStyle(fontFamily: fontFamily, fontSize: 20, color: fontColor),
      labelMedium:
          TextStyle(fontFamily: fontFamily, fontSize: 18, color: fontColor),
      labelSmall:
          TextStyle(fontFamily: fontFamily, fontSize: 16, color: fontColor),
      titleLarge:
          TextStyle(fontFamily: fontFamily, fontSize: 24, color: fontColor),
      titleMedium:
          TextStyle(fontFamily: fontFamily, fontSize: 20, color: fontColor),
      titleSmall:
          TextStyle(fontFamily: fontFamily, fontSize: 18, color: fontColor),
    );
  }

  static CardTheme createCardTheme() {
    return CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
