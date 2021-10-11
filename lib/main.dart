import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/providers/theme_provider.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool _sesionIniciada;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // statusbar transparente
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]); // orientacion vertical
  //await SystemChrome.setEnabledSystemUIOverlays([]); // fullscreen
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  _sesionIniciada = prefs.getBool('sesionIniciada') ?? false;

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) => AuthProvider.instance(),),
      ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider(activarModoNoche: prefs.getBool('activarModoNoche') ?? false)),
      ChangeNotifierProvider(create: (BuildContext context) => AvioncitoProvider()),
    ],
    child: Bienaventurados(),
  ));
}

class Bienaventurados extends StatefulWidget {
  @override
  _BienaventuradosState createState() => _BienaventuradosState();
}

class _BienaventuradosState extends State<Bienaventurados> {

  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Ser Eucaristía',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getTheme,
      initialRoute: _sesionIniciada ? dashboardPage : comenzarPage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
