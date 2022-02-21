import 'package:bienaventurados/src/logic/services/local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificacionesModalWidget extends StatefulWidget {
  final int momentoNotificaciones;
  const NotificacionesModalWidget({Key? key, required this.momentoNotificaciones}) : super(key: key);

  @override
  State<NotificacionesModalWidget> createState() =>
      _NotificacionesModalWidgetState();
}

class _NotificacionesModalWidgetState extends State<NotificacionesModalWidget> {
  late SharedPreferences prefs;
  // late int _momentoNotificaciones;

  @override
  void initState() {
    super.initState();
    obtenerPrefs();
  }

  void obtenerPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Future<void> guardarPrefs(String clave, bool nuevoEstado) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(clave, nuevoEstado);
  // }

  @override
  Widget build(BuildContext context) {

    final LocalNotifications noti = LocalNotifications();
    print(widget.momentoNotificaciones);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                    '¿Cuando te gustaría recibir un recuerdo de tu avioncito diario?',
                    style: Theme.of(context).textTheme.headline6),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sunrise_fea,
                    size: 22, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Tercia',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  '9:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: widget.momentoNotificaciones,
                    value: 9,
                    onChanged: (int? value) {}),
                onTap: () {
                  prefs.setInt('momentoNotificaciones', 9);
                  noti.scheduleDaily9AMNotification(9);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sun_fea,
                    size: 22, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Sexta',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  '12:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: widget.momentoNotificaciones,
                    value: 12,
                    onChanged: (int? value) {}),
                onTap: () {
                  prefs.setInt('momentoNotificaciones', 12);
                  noti.scheduleDaily9AMNotification(12);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sunset_fea,
                    size: 22, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Completas',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  '21:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: widget.momentoNotificaciones,
                    value: 21,
                    onChanged: (int? value) {}),
                onTap: () {
                  prefs.setInt('momentoNotificaciones', 21);
                  noti.scheduleDaily9AMNotification(21);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                leading: Icon(FlutterIcons.slash_fea,
                    size: 22, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Deshabilitadas',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: widget.momentoNotificaciones,
                    value: 0,
                    onChanged: (int? value) {}),
                onTap: () {
                  prefs.setInt('momentoNotificaciones', 0);
                  noti.cancelAllNotification();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
