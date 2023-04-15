import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: coloors.backgrounddark,
    scaffoldBackgroundColor: coloors.backgrounddark,
    extensions: [
      CustomThemeExtension.darkMode,
    ],
    appBarTheme: AppBarTheme(
      backgroundColor: coloors.graybackground,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: coloors.graydark),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    ),
    tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: coloors.graydark,
            width: 2,
          ),
        ),
        unselectedLabelColor: coloors.graydark,
        labelColor: coloors.greendark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: coloors.greendark,
          foregroundColor: coloors.backgrounddark,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: coloors.graybackground,
      modalBackgroundColor: coloors.graybackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: coloors.graybackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: coloors.greendark,
      foregroundColor: Colors.white,
    ),
  );
}
