import 'package:bienaventurados/theme/colores.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  

  void init() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    print('time zone es :$currentTimeZone');
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notification_icon');
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
      largeIcon: DrawableResourceAndroidBitmap('large_icon'),
      color: Colores.acento,
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

  Future<void> scheduleDaily9AMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Bendecido dia!',
        'Un mensaje de amor está esperándote, ve a descubrirlo!',
        _nextInstanceOf9AM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'Daily',
              'Bienaventurados Daily',
              channelDescription: 'Pequeños detalles de amor',
              priority: Priority.max,
              importance: Importance.max,
              largeIcon: DrawableResourceAndroidBitmap('notification_icon'),
              color: Colores.acento,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOf9AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // para prueba se pone 14 pero seria 9am
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
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
      'Bienaventurados Repeat',
      'Bienaventurados Repeat',
      channelDescription: 'Repetiremos sin cansancio que Dios te ama!',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0, 
      'Bienaventurado seas!',
      'Dios te ama, no te olvides nunca.',
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