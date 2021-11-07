import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NotificacionesConfiguracionPage extends StatefulWidget {
  const NotificacionesConfiguracionPage({ Key? key,}) : super(key: key);

  @override
  _NotificacionesConfiguracionPageState createState() => _NotificacionesConfiguracionPageState();
}

class _NotificacionesConfiguracionPageState extends State<NotificacionesConfiguracionPage> {
  late int _opcion;
  
  @override
  void initState() {
    super.initState();
    //noti.init();
  }

  @override
  Widget build(BuildContext context) {
    
    final LocalNotifications noti = LocalNotifications();
    final prefs = PreferenciasUsuario();
    _opcion = prefs.momentoNotificaciones;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                    '¿Cuándo te gustaría recibir un recordatorio de tu avioncito diario?',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    )),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sunrise_fea,
                    size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Tercia',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                subtitle: Text(
                  '9:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: _opcion,
                    value: 9,
                    onChanged: (int? value) {}),
                onTap: () {
                  setState(() {
                if (_opcion != 9) {
                  _opcion = 9;
                  prefs.momentoNotificaciones = 9;
                  noti.scheduleDaily9AMNotification(9);
                }
              });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sun_fea,
                    size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Sexta',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                subtitle: Text(
                  '12:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: _opcion,
                    value: 12,
                    onChanged: (int? value) {}),
                onTap: () {
                  setState(() {
                if (_opcion != 12) {
                  _opcion = 12;
                  prefs.momentoNotificaciones = 12;
                  noti.scheduleDaily9AMNotification(12);
                }
              });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                dense: true,
                leading: Icon(FlutterIcons.sunset_fea,
                    size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Completas',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                subtitle: Text(
                  '21:00 hs.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                trailing: Radio(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    groupValue: _opcion,
                    value: 21,
                    onChanged: (int? value) {}),
                onTap: () {
                  setState(() {
                if (_opcion != 21) {
                  _opcion = 21;
                  prefs.momentoNotificaciones = 21;
                  noti.scheduleDaily9AMNotification(21);
                }
              });
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                leading: Icon(FlutterIcons.slash_fea,
                    size: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark),
                title: Text(
                  'Deshabilitar',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
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
            ],),
      
    );
  }
}