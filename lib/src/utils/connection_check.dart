import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

void connectionCheck(BuildContext context) async {
  int? connection;
  int? lastConnection;
  String? appVersion;
  final prefs = UserPreferences();

  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final paperplaneProvider =
      Provider.of<PaperplaneProvider>(context, listen: false);
  final collectionProvider =
      Provider.of<CollectionProvider>(context, listen: false);
  final achievementProvider =
      Provider.of<AchievementProvider>(context, listen: false);
  appVersion = await getAppVersion();
  connection = DateTime.now().day.toInt();
  lastConnection = prefs.lastConnection;

  if (lastConnection != null) {
    // TODO 1.4.4 - FINALIZADO - PASO PRE-4 - LISTA DE AVIONCITOS EN FIRESTORE
    // paperplaneProvider.createListPaperplanesDB();
    // if (!prefs.migratedPaperplane) {
    /*
        TODO 1.4.4 FINALIZADO - PASO 1 - MIGRACION DE AVIONCITOS FIRESTORE
        */
    // paperplaneProvider.updatePaperplanesAppData().then((result) {
    //   if (result) {
    //     print('AVIONCITOS TRANFERIDOS');
    //   } else {
    //     print('NO SE TRANSFIRIERON LOS AVIONCITOS');
    //   }
    // });

    if (prefs.appVersion != appVersion) {
      print('INICIANDO MIGRACION DE USUARIO');
      await authProvider.migrateUserDB().then((result) {
        if (result) {
          print('USUARIOS MIGRADOS CORRECTAMENTE');
        } else {
          print('ERROR');
        }
      });
      // para evitar que se vuelva a ejecutar este bloque
      prefs.appVersion = appVersion;
    }

    /*
        TODO 1.4.4 FINALIZADO - PASO 2 - MIGRACION DE USUARIOS FIRESTORE
        */
    // print('INICIANDO MIGRACION DE USUARIOS');
    // authProvider.migrateUsersDB().then((result) {
    //   if (result) {
    //     print('USUARIOS MIGRADOS CORRECTAMENTE');
    //   } else {
    //     print('ERROR');
    //   }
    // });

    /* 
        TODO 1.4.4 - PASO 4 usuario - MIGRACION DE AVIONCITOS LOCAL
        */
    // print('MIGRACION DE AVIONCITOS LOCAL');
    // await paperplaneProvider.firstTime();

    //CUANDO SE DESBLOQUEA UN LOGRO O COLECCIONALBE
    //UPDATE COLLECTION
    // authProvider.updateCollectionData('saint-joseph', true).then((result) {
    //   if (result) {
    //     print('DATOS DE COLECCION ACTUALIZADOS');
    //   } else {
    //     print('ERROR');
    //   }
    // });

    // prefs.migratedPaperplane = true;
    //}
    if (connection == lastConnection) {
      print('MISMO DIA');
      //_coleccionDesbloqueada = prefs.coleccionDesbloqueada;
      await paperplaneProvider.isToday();
      await collectionProvider.getCollectibleUnlocked();
      achievementProvider.openAchievements();
      await collectionProvider.openCollectionsBox();
      // print('CONSTANCIA AUMENTADA'); // PARA PROBAR CONSTANCIA
      // achievementProvider.achievementsCheck('constancia'); // PARA PROBAR CONSTANCIA
      // authProvider.increaseConstancy = true; // PARA PROBAR CONSTANCIA
    } else {
      print('NUEVO DIA');
      //authProvider.updateUserData();
      //infoProvider.actualizarInformacionApp('restaurar');
      final lastDay =
          DateTime(DateTime.now().year, DateTime.now().month, lastConnection);
      final newDay =
          DateTime(DateTime.now().year, DateTime.now().month, connection);
      if (lastDay.month == newDay.month || lastDay.month + 1 == newDay.month) {
        if (lastDay.day + 1 == newDay.day || 1 == newDay.day) {
          print('CONSTANCIA AUMENTADA');
          achievementProvider.achievementsCheck('constancia');
          authProvider.increaseConstancy = true;
          //authProvider.actualizarConstancia();
        } else {
          print('CONSTANCIA RESTABLECIDA');
          achievementProvider.restoreConstancy();
          authProvider.restartConstancy = true;
        }
      }
      prefs.lastConnection = connection;
      await paperplaneProvider.isNewDay();
      collectionProvider.openCollectionsBox();
      achievementProvider.openAchievements();
      collectionProvider.collectionsCheck();
    }
  } else {
    print('PRIMERA VEZ');
    lastConnection = connection;
    prefs.lastConnection = connection;
    // para evitar que el codigo unico de cambio de version se ejecute en nuevos usuarios
    prefs.appVersion = await getAppVersion();
    await paperplaneProvider.firstTime();
    collectionProvider.getAllCollections();
    achievementProvider.initAchievements();
    collectionProvider.collectionsCheck();
    achievementProvider.achievementsCheck('primer-inicio');
  }
}
