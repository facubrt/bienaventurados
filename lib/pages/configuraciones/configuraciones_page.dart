import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  // late bool _activarModoNoche;
  // int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final LocalNotifications noti = LocalNotifications();
    // ThemeProvider themeProvider = Provider.of<ThemeProvider>(
    //   context,
    //   listen: false,
    // );

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
                  Navigator.of(context).pushNamed(notificacionesConfiguracionPage);
                  // showMaterialModalBottomSheet(
                  //   expand: false,
                  //   context: context,
                  //   backgroundColor: Colors.transparent,
                  //   builder: (context) => NotificacionesModalWidget(momentoNotificaciones: _momentoNotificaciones),
                  // );
                  // showFloatingModalBottomSheet(
                  //     backgroundColor: Theme.of(context).primaryColor,
                  //     context: context,
                  //     builder: (context) {
                  //       return Container(
                  //           color: Theme.of(context).primaryColor,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(20.0),
                  //             child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                       '¿Cuando te gustaría recibir un recuerdo de tu avioncito diario?',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .headline6),
                  //                   SizedBox(height: 40),
                  //                   ListTile(
                  //                     dense: true,
                  //                     leading: Icon(FlutterIcons.sunrise_fea,
                  //                         size: 22,
                  //                         color: Theme.of(context)
                  //                             .primaryColorDark),
                  //                     title: Text(
                  //                       'Tercia',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .headline6,
                  //                     ),
                  //                     subtitle: Text(
                  //                       '9:00 hs.',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyText2,
                  //                     ),
                  //                     trailing: Radio(
                  //                         activeColor: Theme.of(context)
                  //                             .colorScheme
                  //                             .secondary,
                  //                         groupValue: _value,
                  //                         value: 9,
                  //                         onChanged: (int? value) {}),
                  //                     onTap: () {
                  //                       setState(() {
                  //                         _value = 9;
                  //                       });
                  //                       noti.scheduleDaily9AMNotification(
                  //                           _value);
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                   ListTile(
                  //                     dense: true,
                  //                     leading: Icon(FlutterIcons.sun_fea,
                  //                         size: 22,
                  //                         color: Theme.of(context)
                  //                             .primaryColorDark),
                  //                     title: Text(
                  //                       'Sexta',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .headline6,
                  //                     ),
                  //                     subtitle: Text(
                  //                       '12:00 hs.',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyText2,
                  //                     ),
                  //                     trailing: Radio(
                  //                         activeColor: Theme.of(context)
                  //                             .colorScheme
                  //                             .secondary,
                  //                         groupValue: _value,
                  //                         value: 12,
                  //                         onChanged: (int? value) {}),
                  //                     onTap: () {
                  //                       setState(() {
                  //                         _value = 12;
                  //                       });
                  //                       noti.scheduleDaily9AMNotification(
                  //                           _value);
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                   ListTile(
                  //                     dense: true,
                  //                     leading: Icon(FlutterIcons.sunset_fea,
                  //                         size: 22,
                  //                         color: Theme.of(context)
                  //                             .primaryColorDark),
                  //                     title: Text(
                  //                       'Completas',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .headline6,
                  //                     ),
                  //                     subtitle: Text(
                  //                       '21:00 hs.',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyText2,
                  //                     ),
                  //                     trailing: Radio(
                  //                         activeColor: Theme.of(context)
                  //                             .colorScheme
                  //                             .secondary,
                  //                         groupValue: _value,
                  //                         value: 21,
                  //                         onChanged: (int? value) {}),
                  //                     onTap: () {
                  //                       setState(() {
                  //                         _value = 21;
                  //                       });
                  //                       noti.scheduleDaily9AMNotification(
                  //                           _value);
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                   ListTile(
                  //                     leading: Icon(FlutterIcons.slash_fea,
                  //                         size: 22,
                  //                         color: Theme.of(context)
                  //                             .primaryColorDark),
                  //                     title: Text(
                  //                       'Deshabilitadas',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .headline6,
                  //                     ),
                  //                     trailing: Radio(
                  //                         activeColor: Theme.of(context)
                  //                             .colorScheme
                  //                             .secondary,
                  //                         groupValue: _value,
                  //                         value: 0,
                  //                         onChanged: (int? value) {}),
                  //                     onTap: () {
                  //                       setState(() {
                  //                         _value = 0;
                  //                       });
                  //                       noti.cancelAllNotification();
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                 ]),
                  //           ));
                  //     });
                },
                child: Text('Notificaciones',
                    style: Theme.of(context).textTheme.headline1)),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                // showMaterialModalBottomSheet(
                //   expand: false,
                //   context: context,
                //   backgroundColor: Colors.transparent,
                //   builder: (context) => TemaModalWidget(),
                // );
                Navigator.of(context).pushNamed(temaConfiguracionPage);
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
            'Carlo Acutis (beato) versión 1.2.0'.toUpperCase(),
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
