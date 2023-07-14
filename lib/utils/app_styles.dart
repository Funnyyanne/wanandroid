import 'package:flutter/material.dart';

Color primary = const Color(0xFF687daf);
class Styles{
  static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFeeedf2);
  static Color orangeColor = const Color(0xFFF37B67);
  static Color kakiColor = const Color(0xFFd2bdb6);
  ///颜色
  static Color colorPrimary = Colors.red;
  static Color color_tags = const Color(0xFF009a61);
  static Color color_black = const Color(0xFF000000);
  static Color color_dark_gray = const Color(0xFF6b6b6b);
  static Color color_white_a80 = const  Color(0xccffffff);

  static TextStyle textStyle = TextStyle(fontSize: 16,color: textColor,fontWeight: FontWeight.w500);
  static TextStyle headLinesStyle1 = TextStyle(fontSize: 26,color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLinesStyle2 = TextStyle(fontSize: 21,color: textColor,fontWeight: FontWeight.bold);
  static TextStyle headLinesStyle3 = TextStyle(fontSize: 17,fontWeight: FontWeight.w500);
  static TextStyle headLinesStyle4 = TextStyle(fontSize: 14,color: Colors.grey.shade500,fontWeight: FontWeight.w500);

  static const String themeIndexKey = "themeIndex";

  /* 主题列表 */
  static const Map themeColor = {
    0: {//green
      "primaryColor": Color(0xff4caf50),
      "primaryColorDark": Color(0xff388E3C),
      "colorAccent": Color(0xff8BC34A),
      "colorPrimaryLight": Color(0xffC8E6C9),
    },
    1:{//red
      "primaryColor": Color(0xffF44336),
      "primaryColorDark": Color(0xffD32F2F),
      "colorAccent": Color(0xffFF5252),
      "colorPrimaryLight": Color(0xffFFCDD2),
    },
    2:{//blue
      "primaryColor": Color(0xff2196F3),
      "primaryColorDark": Color(0xff1976D2),
      "colorAccent": Color(0xff448AFF),
      "colorPrimaryLight": Color(0xffBBDEFB),
    },
    3:{//pink
      "primaryColor": Color(0xffE91E63),
      "primaryColorDark": Color(0xffC2185B),
      "colorAccent": Color(0xffFF4081),
      "colorPrimaryLight": Color(0xffF8BBD0),
    },
    4:{//purple
      "primaryColor": Color(0xff673AB7),
      "primaryColorDark": Color(0xff512DA8),
      "colorAccent": Color(0xff7C4DFF),
      "colorPrimaryLight": Color(0xffD1C4E9),
    },
    5:{//grey
      "primaryColor": Color(0xff9E9E9E),
      "primaryColorDark": Color(0xff616161),
      "colorAccent": Color(0xff9E9E9E),
      "colorPrimaryLight": Color(0xffF5F5F5),
    },
    6:{//black
      "primaryColor": Color(0xff333333),
      "primaryColorDark": Color(0xff000000),
      "colorAccent": Color(0xff666666),
      "colorPrimaryLight": Color(0xff999999),
    },
  };
}
