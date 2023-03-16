import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static String assetImagePathNight = "assets/imagesNight/";
  static bool isDriverApp = false;
  static const String fontsFamily = "SF Pro Display";
  static const String fontsFamilySplash = "Avenir-Next-LT-Pro";
  static const String fontsFamilyOffer = "Plantagenet Cherokee";
  static const String fontsFamilyLato = "Lato-semibold";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const String nameSend = "name";
  static const String imageSend = "image";
  static const String bgColor = "bgColor";
  static const String heroKey = "sendHeroKey";
  static const String sendVal = "sendVal";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;
  static const double defScreenWidth = 414;
  static const double defScreenHeight = 896;

  static void setupSize(
    BuildContext context,
      {double width = defScreenWidth, double height = defScreenHeight}) {
    ScreenUtil.init(context,
        designSize: Size(width, height), minTextAdapt: true);
  }

}

