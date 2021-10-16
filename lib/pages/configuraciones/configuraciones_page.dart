import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/providers/theme_provider.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionesPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const ConfiguracionesPage({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  State<ConfiguracionesPage> createState() => _ConfiguracionesPageState();
}

class _ConfiguracionesPageState extends State<ConfiguracionesPage> {
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
    final authProvider = Provider.of<AuthProvider>(context);
    final LocalNotifications noti = LocalNotifications();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Configuraciones',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 4.0),
          child: InkWell(
            onTap: () {
              widget.openDrawer();
            },
            child: Icon(FlutterIcons.menu_fea, size: 24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  ? Text('Notificaciones', style: Theme.of(context).textTheme.headline1)
                  : Text(
                      'Notificaciones',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 4,
                          decorationColor: Theme.of(context).primaryColorDark),
                    ),
            ),
            SizedBox(height: 40),
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
              'Cambiar tema',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              //Navigator.of(context).pushNamed(informacionPage);
            },
            child: Text(
              'Acerca de',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 40),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(informacionPage);
          //   },
          //   child: Text(
          //     'Comp.',
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          // ),
          
          SizedBox(height: 80),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                          width: 2,
                          color: Theme.of(context).primaryColorDark,
                        )),
                        title: Text('Todo camino merece un descanso'),
                        content: Text(
                          '¡Bienaventurado seas! Esperamos verte pronto. Sabemos que este camino todavía tiene muchas sorpresas para vos.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10),
                              child: Text(
                                'Cancelar',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color:
                                            Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              authProvider.signOut();
                              SharedPrefs.limpiarPrefs();
                              //SharedPrefs.guardarPrefs('sesionIniciada', false);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  comenzarPage, (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10),
                              child: Text(
                                'Confirmar',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                        ],
                      ));
            },
            child: Text(
              'Salir',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),

          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'Carlo Acutis (beato) versión 1.1.0'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
