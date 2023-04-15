import 'package:flutter/material.dart';
import 'package:whats_app_me/common/utils/coloors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static const lightMode = CustomThemeExtension(
      circleimagecolor: Color(0xFF25D366),
      graycolor: coloors.graylight,
      bluecolor: coloors.blueLight,
      langBtnBgcolor: Color(0xFFF7F8FA),
      langBtnHighlightcolor: Color(0xFFE8E8ED),
      authAppbarTextColor: coloors.greenLight,
      photoIconBgColor: Color(0xFFF0F2F3),
      phototIconColor: Color(0xFF9DAAB3),
  );


  static const darkMode = CustomThemeExtension(
      circleimagecolor: coloors.greendark,
      graycolor: coloors.graydark,
      bluecolor: coloors.bluedark,
      langBtnBgcolor: Color(0xFF182229),
      langBtnHighlightcolor: Color(0xFF09141A),
      authAppbarTextColor: Color(0xFFE9EDEF),
      phototIconColor: Color(0XFF283339),
      photoIconBgColor: Color(0xFF61717B)
      
  
  
  );

  final Color? circleimagecolor;
  final Color? graycolor;
  final Color? bluecolor;
  final Color? langBtnBgcolor;
  final Color? langBtnHighlightcolor;
  final Color? authAppbarTextColor;
  final Color? photoIconBgColor;
  final Color? phototIconColor;

  const CustomThemeExtension( 
      {this.circleimagecolor,
      this.graycolor,
      this.bluecolor,
      this.langBtnBgcolor,
      this.langBtnHighlightcolor,
      this.authAppbarTextColor,
      this.photoIconBgColor,
      this.phototIconColor
      });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? circleimagecolor,
    Color? graycolor,
    Color? bluecolor,
    Color? langBtnBgcolor,
    Color? langBtnHighlightcolor,
    Color? photoIconBgColor,
    Color? phototIconColor,

  }) {
    return CustomThemeExtension(
      circleimagecolor: circleimagecolor ?? this.circleimagecolor,
      graycolor: graycolor ?? this.graycolor,
      bluecolor: bluecolor ?? this.bluecolor,
      langBtnBgcolor: langBtnBgcolor ?? this.langBtnBgcolor,
      authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
      photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
      phototIconColor: phototIconColor ?? this.phototIconColor,
      langBtnHighlightcolor:
          langBtnHighlightcolor ?? this.langBtnHighlightcolor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
        circleimagecolor: Color.lerp(circleimagecolor, circleimagecolor, t),
        graycolor: Color.lerp(graycolor, graycolor, t),
        bluecolor: Color.lerp(bluecolor, bluecolor, t),
      phototIconColor: Color.lerp(phototIconColor, phototIconColor, t),
        langBtnBgcolor: Color.lerp(langBtnBgcolor, langBtnBgcolor, t),
        authAppbarTextColor:
            Color.lerp(authAppbarTextColor, authAppbarTextColor, t),
        langBtnHighlightcolor:
            Color.lerp(langBtnHighlightcolor, langBtnHighlightcolor, t),
          photoIconBgColor:Color.lerp(photoIconBgColor, photoIconBgColor, t),



    );
  }
}
