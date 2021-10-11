import 'package:bienaventurados/theme/colores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData? _selectedTheme;

  ThemeData day = ThemeData(
    textTheme: TextTheme(
      // ESTILO DE FUENTE PARA FRASE
      headline1: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // ESTILO DE FUENTE PARA SANTOS Y ENCABEZADOS
      headline2: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // utilizados en appbar y encabezados pequeños
      headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.6)),
      // // utilizado para la firma Bienanventurados en HoyPage
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      
      bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: 'Gotham',fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.italic, color: Colores.primarioNight),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // button: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // overline: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Gotham', fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colores.primarioNight),
    ),
    fontFamily: 'Gotham',
    //accentColor: Colores.acento,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colores.acento
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colores.primarioNight),
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(Colores.acento),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20)),
      )
    ),
    colorScheme: ColorScheme(
      primary: Colores.primarioDay,
      primaryVariant: Colores.primarioNight,
      secondary: Colores.acento,
      surface: Colores.primarioDay,
      background: Colors.deepOrange,
      error: Colors.greenAccent,
      secondaryVariant: Colors.yellowAccent,
      brightness: Brightness.light,
      onBackground: Colors.red,
      onError: Colors.blue,
      onPrimary: Colores.primarioNight,
      onSecondary: Colors.green,
      onSurface: Colores.primarioNight,
    ),
    scaffoldBackgroundColor: Colores.primarioDay,
    primaryColor: Colores.primarioDay,
    // disabledColor: Colores.secundarioDay,
    // cardColor: Colores.secundarioDay,
    // brightness: Brightness.light,
    // dividerColor: Colores.contrasteDay,
    hoverColor: Colores.contrasteDay, // color de contraste
    highlightColor: Colors.transparent, // resaltados y tabs
    dialogBackgroundColor: Colores.primarioDay,
    primaryColorDark: Colores.contrasteDay,
  );

  ThemeData night = ThemeData(
    textTheme: TextTheme(
      // ESTILO DE FUENTE PARA FRASE
      headline1: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // ESTILO DE FUENTE PARA SANTOS Y ENCABEZADOS
      headline2: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // utilizados en appbar y encabezados pequeños
      headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.6)),
      // // utilizado para la firma Bienanventurados en HoyPage
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      
      bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: 'Gotham',fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.italic, color: Colores.primarioNight),
      subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.acento),
      // caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // button: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay),
      // overline: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Gotham', fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colores.primarioNight),
    ),
    fontFamily: 'Montserrat',
    //accentColor: Colores.acento,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colores.acento 
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colores.primarioDay),
        shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
      )
    ),
    colorScheme: ColorScheme(
      primary: Colores.primarioNight,
      primaryVariant: Colores.primarioDay,
      secondary: Colores.acento,
      surface: Colores.primarioNight,
      background: Colors.deepOrange,
      error: Colors.greenAccent,
      secondaryVariant: Colores.primarioDay,
      brightness: Brightness.dark,
      onBackground: Colors.red,
      onError: Colors.blue,
      onPrimary: Colores.primarioDay,
      onSecondary: Colors.green,
      onSurface: Colores.primarioDay,
    ),
    scaffoldBackgroundColor: Colores.primarioNight,
    primaryColor: Colores.primarioNight,
    //disabledColor: Colores.secundarioNight,
    //cardColor: Colores.secundarioNight,
    //brightness: Brightness.dark,
    //dividerColor: Colores.contrasteNight,
    hoverColor: Colores.contrasteNight,
    //hintColor: Colores.contrasteNight,
    //shadowColor: Colores.secundarioNight,
    highlightColor: Colors.transparent,
    dialogBackgroundColor: Colores.primarioNight,
    primaryColorDark: Colores.contrasteNight,
  );

  ThemeProvider({required bool activarModoNoche}){
    _selectedTheme = activarModoNoche ? night : day;
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == night){
      _selectedTheme = day;
      await prefs.setBool('activarModoNoche', false);
    } else {
      _selectedTheme = night;
      await prefs.setBool('activarModoNoche', true);
    }
    notifyListeners();
  }

  ThemeData? get getTheme => _selectedTheme;
}