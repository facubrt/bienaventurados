import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/local_notifications.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationsPageState createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends State<NotificationsPage> {
  late int _option;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LocalNotifications noti = LocalNotifications();
    final prefs = UserPreferences();
    _option = prefs.notificationsHour;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Text('Notificaciones'),
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
                NOTI_PAGE_TITLE,
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
              NOTI_ON_TITLE,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                NOTI_ON_TEXT,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.4),
                    ),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _option,
                value: 9,
                onChanged: (int? value) {}),
            onTap: () async {
              setState((){
                if (_option != 9) {
                  _option = 9;
                  prefs.notificationsHour = 9;
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
              NOTI_OFF_TITLE,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                NOTI_OFF_TEXT,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.4),
                    ),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _option,
                value: 0,
                onChanged: (int? value) {}),
            onTap: () {
              setState(() {
                if (_option != 0) {
                  _option = 0;
                  prefs.notificationsHour = 0;
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
