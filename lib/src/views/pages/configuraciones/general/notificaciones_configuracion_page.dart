import 'package:bienaventurados/src/logic/services/local_notifications.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificacionesConfiguracionPage extends StatefulWidget {
  const NotificacionesConfiguracionPage({
    Key? key,
  }) : super(key: key);

  @override
  _NotificacionesConfiguracionPageState createState() =>
      _NotificacionesConfiguracionPageState();
}

class _NotificacionesConfiguracionPageState
    extends State<NotificacionesConfiguracionPage> {
  late int _opcion;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocalNotifications noti = LocalNotifications();
    final prefs = PreferenciasUsuario();
    _opcion = prefs.momentoNotificaciones;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Notificaciones'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
                '¿Te gustaría recibir un recordatorio de tu avioncito diario?',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    )),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            dense: true,
            leading: Icon(Iconsax.notification_1,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).primaryColorDark),
            title: Text(
              'Recibir notificaciones',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Selecciona esta opción si deseas que te enviemos una notificación cuando tu avioncito diario esté listo.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.4),
                    ),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _opcion,
                value: 9,
                onChanged: (int? value) {}),
            onTap: () async {
              setState((){
                if (_opcion != 9) {
                  _opcion = 9;
                  prefs.momentoNotificaciones = 9;
                  noti.scheduleDaily9AMNotification(9);
                }
              });
            },
          ),
          Divider(
              height: 0,
              color: Theme.of(context).primaryColorDark,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            dense: true,
            leading: Icon(Iconsax.close_square,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).primaryColorDark),
            title: Text(
              'No recibir notificaciones',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Selecciona esta opción si no deseas recibir notificaciones.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.4),
                    ),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _opcion,
                value: 0,
                onChanged: (int? value) {}),
            onTap: () {
              setState(() {
                if (_opcion != 0) {
                  _opcion = 0;
                  prefs.momentoNotificaciones = 0;
                  noti.cancelAllNotification();
                }
              });
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
