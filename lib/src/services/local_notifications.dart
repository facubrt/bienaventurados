import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  

  void init() async {
    // HACER CONDICIONAL SEGÚN LOS SHAREDPREFERENCES. SI LAS NOTIFICACIONES ESTAN ACTIVIDAS O NO
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notificacion_icono');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
      // IOS NO IMPLEMENTADO
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotifications (String title) async {
    const AndroidNotificationDetails androidPlatformSpecifics = AndroidNotificationDetails(
      'your channel', 
      'channel name', 
      channelDescription: 'channelDescription',
      priority: Priority.max,
      importance: Importance.max,
      // largeIcon: DrawableResourceAndroidBitmap('notificacion_icono'),
      color: ColorPalette.accent,
    );
    // IOS NO IMPLEMENTADO
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformSpecifics,
      // IOS NO IMPLEMENTADO
    );
    await flutterLocalNotificationsPlugin.show(
      0, 
      title, 
      'dentro de la notificacion', 
      platformChannelSpecifics,
    );
  }

  Future<void> scheduleWeeklyNotification(int dia, int hora, int minuto)async{

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'id',
        'name',
        channelDescription: 'description',
        priority: Priority.max,
        importance: Importance.max,
        
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, 
      'notification for Tomorrow', 
      'body', 
      _netxInstanceOfDay(dia, hora, minuto), 
      details,       
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,                   
      );

  }

  tz.TZDateTime _netxInstanceOfDay(int dia, int hora, int minuto) {
    tz.TZDateTime scheduleDate = _nextIntance(dia, hora, minuto);
    //while(scheduleDate.weekday  != DateTime.friday ){
      //scheduleDate = scheduleDate.add(Duration(days: 1));
    //}
    return scheduleDate;

  }

  tz.TZDateTime _nextIntance(int dia, int hora, int minuto) {

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, dia, hora, minuto);
    if( scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;


  }

  Future<void> scheduleDaily9AMNotification(int hour) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        DAILY_NOTIFICATION_TITLE,
        DAILY_NOTIFICATION_TEXT,
        _nextInstanceOf9AM(hour),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              DAILY_CHANNEL_ID,
              DAILY_CHANNEL_NAME,
              channelDescription: DAILY_CHANNEL_DESCRIPTION,
              priority: Priority.max,
              importance: Importance.max,
              color: ColorPalette.accent,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOf9AM(int hour) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, 0, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1, hours: 0, minutes: 0, seconds: 0));
    }
    return scheduledDate;
  }

  Future<void> scheduleNext10SecondsNotification()async{

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'id',
        'name',
        channelDescription: 'description',
        priority: Priority.max,
        importance: Importance.max,
        
      ),
    );
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = now.add(Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, 
      'notification for 5 seconds', 
      'in 5 seconds', 
      scheduleDate, 
      details,       
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,                   
      );

  }

  Future<void> repeatNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      REPEAT_CHANNEL_ID,
      REPEAT_CHANNEL_NAME,
      channelDescription: REPEAT_CHANNEL_DESCRIPTION,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1, 
      REPEAT_NOTIFICATION_TITLE,
      REPEAT_NOTIFICATION_TEXT,
      RepeatInterval.hourly,
      platformChannelSpecifics,
      androidAllowWhileIdle: true
    );
  }
  
   Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}