import 'package:bienaventurados/theme/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData? _selectedTheme;

  ThemeData day = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    textTheme: TextTheme(
      // ESTILO DE FUENTE PARA FRASE
      headline1: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // ESTILO DE FUENTE PARA SANTOS Y ENCABEZADOS
      headline2: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // utilizados en appbar y encabezados pequeños
      headline4: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      // headline5: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.6)),
      // // utilizado para la firma Bienanventurados en HoyPage
      headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight),
      
      bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham',fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.8)),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioNight.withOpacity(0.8)),
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
    // dividerColor: Colores.contrasteDay,
    hoverColor: Colores.contrasteDay, // color de contraste
    highlightColor: Colors.transparent, // resaltados y tabs
    dialogBackgroundColor: Colores.primarioDay,
    primaryColorDark: Colores.contrasteDay,
  );

  ThemeData night = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
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
      
      bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham',fontStyle: FontStyle.normal, color: Colores.primarioDay.withOpacity(0.8),),
      bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Gotham', fontStyle: FontStyle.normal, color: Colores.primarioDay.withOpacity(0.8)),
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
        shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(Colores.acento),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20)),
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
    cardColor: Colores.secundarioNight,
    //dividerColor: Colores.contrasteNight,
    hoverColor: Colores.contrasteNight,
    hintColor: Colores.contrasteNight,
    shadowColor: Colores.secundarioNight,
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
      await prefs.setBool('modoNoche', false);
    } else {
      _selectedTheme = night;
      await prefs.setBool('modoNoche', true);
    }
    notifyListeners();
  }

  Future<void> activarModoNoche(bool modoNoche) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (modoNoche){
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