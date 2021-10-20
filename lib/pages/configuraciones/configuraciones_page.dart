import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/providers/theme_provider.dart';
import 'package:bienaventurados/widgets/floating_modal.dart';
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
  int _value = 1;

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
    final LocalNotifications noti = LocalNotifications();
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: false,);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: () {
              widget.openDrawer();
            },
            icon: Icon(FlutterIcons.menu_fea, size: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
                onTap: () {
                  showFloatingModalBottomSheet(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return Container(
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '¿Cuando te gustaría recibir un recuerdo de tu avioncito diario?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    SizedBox(height: 40),
                                    ListTile(
                                      dense: true,
                                      leading: Icon(FlutterIcons.sunrise_fea,
                                          size: 22,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      title: Text(
                                        'Tercia',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      subtitle: Text(
                                        '9:00 hs.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      trailing: Radio(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          groupValue: _value,
                                          value: 9,
                                          onChanged: (int? value) {}),
                                      onTap: () {
                                        setState(() {
                                          _value = 9;
                                        });
                                        noti.scheduleDaily9AMNotification(
                                            _value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      dense: true,
                                      leading: Icon(FlutterIcons.sun_fea,
                                          size: 22,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      title: Text(
                                        'Sexta',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      subtitle: Text(
                                        '12:00 hs.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      trailing: Radio(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          groupValue: _value,
                                          value: 12,
                                          onChanged: (int? value) {}),
                                      onTap: () {
                                        setState(() {
                                          _value = 12;
                                        });
                                        noti.scheduleDaily9AMNotification(
                                            _value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      dense: true,
                                      leading: Icon(FlutterIcons.sunset_fea,
                                          size: 22,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      title: Text(
                                        'Completas',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      subtitle: Text(
                                        '21:00 hs.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      trailing: Radio(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          groupValue: _value,
                                          value: 21,
                                          onChanged: (int? value) {}),
                                      onTap: () {
                                        setState(() {
                                          _value = 21;
                                        });
                                        noti.scheduleDaily9AMNotification(
                                            _value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(FlutterIcons.slash_fea,
                                          size: 22,
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      title: Text(
                                        'Deshabilitadas',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      trailing: Radio(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          groupValue: _value,
                                          value: 0,
                                          onChanged: (int? value) {}),
                                      onTap: () {
                                        setState(() {
                                          _value = 0;
                                        });
                                        noti.cancelAllNotification();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]),
                            ));
                      });
                },
                child: Text('Notificaciones',
                    style: Theme.of(context).textTheme.headline1)),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                showFloatingModalBottomSheet(
                  backgroundColor: Theme.of(context).primaryColor,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Elige el tema que más te guste',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(height: 40),
                            ListTile(
                              dense: true,
                              isThreeLine: true,
                              leading: Icon(FlutterIcons.sun_fea,
                                  size: 22,
                                  color: Theme.of(context).primaryColorDark),
                              title: Text(
                                'Claro',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              subtitle: Text(
                                'Ilumina otros corazones con tu luz.',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Radio(
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                  groupValue: _value,
                                  value: 2,
                                  onChanged: (int? value) {}),
                              onTap: () {
                                setState(() {
                                  if (_value != 2) {
                                    _value = 2;
                                    themeProvider.swapTheme();
                                    _activarModoNoche = !_activarModoNoche;
                                    guardarPrefs('activarModoNoche', _activarModoNoche);
                                  }
                                });
                                
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              dense: true,
                              isThreeLine: true,
                              leading: Icon(FlutterIcons.moon_fea,
                                  size: 22,
                                  color: Theme.of(context).primaryColorDark),
                              title: Text(
                                'Oscuro',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              subtitle: Text(
                                'Aventurate en el silencio de la noche.',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              trailing: Radio(
                                  activeColor:
                                      Theme.of(context).colorScheme.secondary,
                                  groupValue: _value,
                                  value: 1,
                                  onChanged: (int? value) {}),
                              onTap: () {
                                setState(() {
                                  if (_value != 1) {
                                    _value = 1;
                                    themeProvider.swapTheme();
                                    _activarModoNoche = !_activarModoNoche;
                                    guardarPrefs('activarModoNoche', _activarModoNoche);
                                  }
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
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
