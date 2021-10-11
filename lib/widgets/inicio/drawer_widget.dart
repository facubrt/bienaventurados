import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/providers/theme_provider.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late SharedPreferences prefs;
  late bool _activarModoNoche;
  bool _activarNotificaciones = true;

  @override
  void initState() {
    super.initState();
    obtenerPrefs();
    //noti.init();
  }

  void obtenerPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _activarModoNoche = prefs.getBool('activarModoNoche') ?? false;
    _activarNotificaciones = prefs.getBool('activarNotificaciones') ?? true;
  }

  Future<void> guardarPrefs(String clave, bool nuevoEstado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(clave, nuevoEstado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bien\naven\ntura\ndos',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 68)),
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            buildDrawerItems(context),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'Pier Giorgio Frassati (beato) versión 1.0.0'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final LocalNotifications noti = LocalNotifications();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // InkWell(
        //   onTap: () {
        //     Navigator.of(context).pushNamed(configuracionesPage);
        //   },
        //   child: Text(
        //     'Config',
        //     style: Theme.of(context).textTheme.headline1,
        //   ),
        // ),
        // SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(construirPage);
          },
          child: Text(
            'Const.',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            setState(() {
              _activarNotificaciones = !_activarNotificaciones;
            });
            if (_activarNotificaciones) {
              print('notificacion activada');
              //noti.showNotifications('Bienaventurado seas!');
              noti.scheduleDaily9AMNotification();
            } else {
              print('notificaciones desactivadas');
              noti.cancelAllNotification();
            }
            guardarPrefs('activarNotificaciones', _activarNotificaciones);
          },
          child: _activarNotificaciones 
          ? Text(
            'Notif.',
            style: Theme.of(context).textTheme.headline1
          )
          : Text(
            'Notif.',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                decoration: TextDecoration.lineThrough,
                decorationThickness: 4,
                decorationColor: Theme.of(context).primaryColorDark),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            ThemeProvider themeProvider = Provider.of<ThemeProvider>(
              context,
              listen: false,
            );
            themeProvider.swapTheme();
            _activarModoNoche = !_activarModoNoche;
            guardarPrefs('activarModoNoche', _activarModoNoche);
          },
          child: Text(
            'Tema',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            print('tap');
          },
          child: Text(
            'Info.',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 40),
        InkWell(
          onTap: () {
            authProvider.signOut();
            SharedPrefs.limpiarPrefs();
            //SharedPrefs.guardarPrefs('sesionIniciada', false);
            Navigator.of(context).pushNamedAndRemoveUntil(comenzarPage, (route) => false);
          },
          child: Text(
            'Salir',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Theme.of(context).accentColor),
          ),
        )
      ],
    );
  }
}
