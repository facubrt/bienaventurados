import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;

  ThemeData day = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: TextTheme(
      // ESTILO DE FUENTE PARA FRASE
      headline1: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w900,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark),
      // ESTILO DE FUENTE PARA SANTOS Y ENCABEZADOS
      headline2: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark),
      // utilizados en appbar y encabezados pequeños
      headline4: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark),
      // headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.6)),
      // // utilizado para la firma Bienanventurados en HoyPage
      headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark),

      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark.withOpacity(0.8)),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryDark.withOpacity(0.8)),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.accent),
      // subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // button: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // overline: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Gotham', fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colores.primarioNight),
    ),
    fontFamily: 'Gotham',
    //accentColor: Colores.acento,
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: ColorPalette.accent),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(ColorPalette.primaryDark),
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(ColorPalette.accentSecondary),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 20)),
    )),
    colorScheme: ColorScheme(
      primary: ColorPalette.primaryLight,
      //primaryVariant: Colores.primarioNight,
      secondary: ColorPalette.accent,
      surface: ColorPalette.primaryLight,
      background: Colors.deepOrange,
      error: Colors.greenAccent,
      tertiary: ColorPalette.accentSecondary,
      //secondaryVariant: Colors.yellowAccent,
      brightness: Brightness.light,
      onBackground: Colors.red,
      onError: Colors.blue,
      onPrimary: ColorPalette.primaryDark,
      onSecondary: Colors.green,
      onSurface: ColorPalette.primaryDark,
    ),
    chipTheme: ChipThemeData(
      selectedColor: ColorPalette.accent,
      backgroundColor: ColorPalette.accentDark.withOpacity(0.05),
      shadowColor: Colors.transparent,
      disabledColor: ColorPalette.accentDark.withOpacity(0.05),
      checkmarkColor: Colors.yellow,
      selectedShadowColor: Colors.transparent,
      deleteIconColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: ColorPalette.primaryLight,
    primaryColor: ColorPalette.primaryLight,
    shadowColor: ColorPalette.secondaryLight,
    // disabledColor: Colores.secundarioDay,
    // cardColor: Colores.secundarioDay,
    // dividerColor: Colores.primaryDark,
    hoverColor: ColorPalette.primaryDark, // color de contraste
    highlightColor: Colors.transparent, // resaltados y tabs
    dialogBackgroundColor: ColorPalette.primaryLight,
    primaryColorDark: ColorPalette.primaryDark,
  );

  ThemeData night = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    textTheme: TextTheme(
      // ESTILO DE FUENTE PARA FRASE
      headline1: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.w900,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryLight),
      // ESTILO DE FUENTE PARA SANTOS Y ENCABEZADOS
      headline2: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryLight),
      // utilizados en appbar y encabezados pequeños
      headline4: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryLight),
      // headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.6)),
      // // utilizado para la firma Bienanventurados en HoyPage
      headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryLight),

      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontFamily: 'Gotham',
        fontStyle: FontStyle.normal,
        color: ColorPalette.primaryLight.withOpacity(0.8),
      ),
      bodyText2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.primaryLight.withOpacity(0.8)),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gotham',
          fontStyle: FontStyle.normal,
          color: ColorPalette.accent),
      // subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // button: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // overline: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Gotham', fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colores.primarioNight),
    ),
    fontFamily: 'Montserrat',
    //accentColor: Colores.acento,
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: ColorPalette.accent),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(ColorPalette.primaryLight),
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(ColorPalette.accentSecondary),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 20)),
    )),
    colorScheme: ColorScheme(
      primary: ColorPalette.primaryDark,
      //primaryVariant: Colores.primarioDay,
      secondary: ColorPalette.accent,
      surface: ColorPalette.primaryDark,
      background: Colors.deepOrange,
      error: Colors.greenAccent,
      //secondaryVariant: Colores.primarioDay,
      tertiary: ColorPalette.accentSecondary,
      brightness: Brightness.dark,
      onBackground: Colors.red,
      onError: Colors.blue,
      onPrimary: ColorPalette.primaryLight,
      onSecondary: Colors.green,
      onSurface: ColorPalette.primaryLight,
    ),
    chipTheme: ChipThemeData(
      selectedColor: ColorPalette.accent,
      backgroundColor: ColorPalette.accentDark,
      shadowColor: Colors.transparent,
      disabledColor: ColorPalette.accentDark.withOpacity(0.05),
      checkmarkColor: Colors.yellow,
      selectedShadowColor: Colors.transparent,
      deleteIconColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: ColorPalette.primaryDark,
    primaryColor: ColorPalette.primaryDark,
    //disabledColor: Colores.secundarioNight,
    cardColor: ColorPalette.accentDark,
    //dividerColor: Colores.primaryLight,
    hoverColor: ColorPalette.primaryLight,
    hintColor: ColorPalette.primaryLight,
    shadowColor: ColorPalette.accentDark,
    highlightColor: Colors.transparent,
    dialogBackgroundColor: ColorPalette.primaryDark,
    primaryColorDark: ColorPalette.primaryLight,
  );

  ThemeProvider({required bool activarModoNoche}) {
    _selectedTheme = activarModoNoche ? night : day;
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == night) {
      _selectedTheme = day;
      await prefs.setBool('modoNoche', false);
    } else {
      _selectedTheme = night;
      await prefs.setBool('modoNoche', true);
    }
    notifyListeners();
  }

  Future<void> activarModoNoche(bool modoNoche) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (modoNoche) {
      _selectedTheme = night;
      await prefs.setBool('modoNoche', true);
    } else {
      _selectedTheme = day;
      await prefs.setBool('modoNoche', false);
    }
    notifyListeners();
  }

  ThemeData? get getTheme => _selectedTheme;
}
