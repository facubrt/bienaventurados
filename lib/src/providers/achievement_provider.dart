import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/data/local/local_db.dart';
import 'package:bienaventurados/src/data/local/achievements_data.dart';
import 'package:bienaventurados/src/models/logro_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AchievementProvider with ChangeNotifier {
  final LocalData _localDB = LocalData();

  Future<void> initAchievements() async {
    // TODO ACA DEBERIA RECIBIRSE EL ARRAY DE INSIGNIAS EN LA NUBE Y COMPROBAR. SI LA INSIGNIA ESTABA DESBLOQUEADA, SETEARLA COMO DESBLOQUEADA
    // TAMBIEN SETEAR N = MAXIMO SI YA ESTA DESBLOQUEADO
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        for (var i = 0; i < Achievements.allAchievements.length; i++) {
          _localDB.setLogro(Achievements.allAchievements[i], false);
        }
      }
    });
  }

  Future<bool> setAchievement(Logro achievement, bool isUnlocked) async {
    _localDB.setLogro(achievement, isUnlocked);
    notifyListeners();
    return true;
  }

  Future<void> achievementsCheck(String title) async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        Box? box = _localDB.getLogros();
        switch (title) {
          case ACHIEVEMENT_FIRST_TIME:
            firstTime(box);
            break;
          case ACHIEVEMENT_CONSTANCY:
            constancy(box);
            break;
          case ACHIEVEMENT_SAVED:
            saved(box);
            break;
          case ACHIEVEMENT_RATING_APP:
            ratingApp(box);
            break;
          case ACHIEVEMENT_SHARED:
            shared(box);
            break;
          case ACHIEVEMENT_SHARE_APP:
            shareApp(box);
            break;
          case ACHIEVEMENT_BUILDED:
            builded(box);
            break;
          case ACHIEVEMENT_NIGHT_MODE:
            darkMode(box);
            break;
        }
      }
    });
  }

  //
  void darkMode(Box? box) {
    Logro achievement = box!.getAt(15);
    if (!achievement.desbloqueado) {
      achievement.n += 1;
      updateAchievement(achievement);
    }
  }

  void builded(Box? box) {
    Logro achievement = box!.getAt(12);
    if (achievement.desbloqueado) {
      achievement = box.getAt(13);
      if (achievement.desbloqueado) {
        achievement = box.getAt(14);
        if (achievement.desbloqueado) {
        } else {
          print('LOGRO NO DESBLOQUEADO');
          achievement.n += 1;
          updateAchievement(achievement);
        }
      } else {
        print('LOGRO NO DESBLOQUEADO');
        achievement.n += 1;
        updateAchievement(achievement);
      }
    } else {
      print('LOGRO NO DESBLOQUEADO');
      achievement.n += 1;
      updateAchievement(achievement);
    }
  }

  void shareApp(Box? box) {
    Logro achievement = box!.getAt(11);
    if (achievement.desbloqueado) {
      print('LOGRO YA DESBLOQUEADO');
    } else {
      print('LOGRO NO DESBLOQUEADO');
      achievement.n += 1;
      updateAchievement(achievement);
    }
  }

  void shared(Box? box) {
    print('LOGRO COMPARTIDOS');
    Logro achievement = box!.getAt(8);
    if (achievement.desbloqueado) {
      print('PRIMERA VEZ DESBLOQUEADO');
      achievement = box.getAt(9);
      if (achievement.desbloqueado) {
        print('SEGUNDA VEZ DESBLOQUEADO');
        achievement = box.getAt(10);
        if (achievement.desbloqueado) {
          print('TERCERA VEZ DESBLOQUEADO');
        } else {
          achievement.n += 1;
          print('ACCION REALIZADA ${achievement.n}');
          updateAchievement(achievement);
        }
      } else {
        achievement.n += 1;
        print('ACCION REALIZADA ${achievement.n}');
        updateAchievement(achievement);
      }
    } else {
      achievement.n += 1;
      print('ACCION REALIZADA ${achievement.n}');
      updateAchievement(achievement);
    }
  }

  void ratingApp(Box? box) {
    Logro achievement = box!.getAt(7);
    if (achievement.desbloqueado) {
      print('LOGRO YA DESBLOQUEADO');
    } else {
      print('LOGRO NO DESBLOQUEADO');
      achievement.n += 1;
      updateAchievement(achievement);
    }
  }

  void saved(Box? box) {
    Logro achievement = box!.getAt(4);
    if (achievement.desbloqueado) {
      print('PRIMER NIVEL DESBLOQUEADO');
      achievement = box.getAt(5);
      if (achievement.desbloqueado) {
        print('SEGUNDO NIVEL DESBLOQUEADO');
        achievement = box.getAt(6);
        if (achievement.desbloqueado) {
          print('TERCER NIVEL DESBLOQUEADO');
        } else {
          achievement.n += 1;
          print('ACCION REALIZADA ${achievement.n}');
          updateAchievement(achievement);
        }
      } else {
        achievement.n += 1;
        print('ACCION REALIZADA ${achievement.n}');
        updateAchievement(achievement);
      }
    } else {
      achievement.n += 1;
      print('ACCION REALIZADA ${achievement.n}');
      updateAchievement(achievement);
    }
  }

  Future<void> decreaseSaved() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        Box? box = _localDB.getLogros();
        Logro achievement = box!.getAt(4);
        if (achievement.desbloqueado) {
          print('PRIMER NIVEL DESBLOQUEADO');
          achievement = box.getAt(5);
          if (achievement.desbloqueado) {
            print('SEGUNDO NIVEL DESBLOQUEADO');
            achievement = box.getAt(6);
            if (achievement.desbloqueado) {
              print('TERCER NIVEL DESBLOQUEADO');
            } else {
              achievement.n -= 1;
              print('ACCION REALIZADA ${achievement.n}');
              updateAchievement(achievement);
            }
          } else {
            achievement.n -= 1;
            print('ACCION REALIZADA ${achievement.n}');
            updateAchievement(achievement);
          }
        } else {
          achievement.n -= 1;
          print('ACCION REALIZADA ${achievement.n}');
          updateAchievement(achievement);
        }
      }
    });
  }

  void firstTime(Box? box) {
    Logro achievement = box!.getAt(0);
    if (!achievement.desbloqueado) {
      achievement.n += 1;
      updateAchievement(achievement);
    }
  }

  void constancy(Box? box) {
    Logro achievement = box!.getAt(1);
    if (achievement.desbloqueado) {
      print('PRIMERA VEZ DESBLOQUEADO');
      achievement = box.getAt(2);
      if (achievement.desbloqueado) {
        print('SEGUNDA VEZ DESBLOQUEADO');
        achievement = box.getAt(3);
        if (achievement.desbloqueado) {
          print('TERCERA VEZ DESBLOQUEADO');
        } else {
          achievement.n += 1;
          print('ACCION REALIZADA ${achievement.n}');
          updateAchievement(achievement);
        }
      } else {
        achievement.n += 1;
        print('ACCION REALIZADA ${achievement.n}');
        updateAchievement(achievement);
      }
    } else {
      achievement.n += 1;
      print('ACCION REALIZADA ${achievement.n}');
      updateAchievement(achievement);
    }
  }

  //

  Future<bool> openAchievements() async {
    bool result = false;
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        result = true;
      }
    });
    return result;
  }

  Box getAchievements() {
    return _localDB.logrosBox!;
  }

  void updateAchievement(Logro achievement) {
    if (achievement.n == achievement.maximo) {
      setAchievement(achievement, true);
      showMessage(achievement);
    } else {
      setAchievement(achievement, false);
    }
  }

  void showMessage(Logro achievement) {
    Fluttertoast.showToast(
        msg: "¡Felicidades! Has desbloqueado ${achievement.titulo}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorPalette.accentSecondary,
        textColor: ColorPalette.primaryLight,
        fontSize: 14.0);
  }

  //void desbloquearLogro(String logro) {}

  void restoreAchievements(String achievement) {}

  Future<void> restoreConstancy() async {
    await _localDB.openBox().then((isOpenBox) async {
      if (isOpenBox) {
        Box? box = _localDB.getLogros();
        Logro achievement = box!.getAt(1);
        if (achievement.desbloqueado) {
          print('PRIMERA VEZ DESBLOQUEADO');
          achievement = box.getAt(2);
          if (achievement.desbloqueado) {
            print('SEGUNDA VEZ DESBLOQUEADO');
            achievement = box.getAt(3);
            if (achievement.desbloqueado) {
              print('TERCERA VEZ DESBLOQUEADO');
            } else {
              print('TERCER LOGRO RESTABLECIDO');
              achievement.n = Achievements.allAchievements[achievement.id].n;
              _localDB.setLogro(achievement, false);
            }
          } else {
            print('SEGUNDO LOGRO RESTABLECIDO');
            achievement.n = Achievements.allAchievements[achievement.id].n;
            _localDB.setLogro(achievement, false);
          }
        } else {
          print('PRIMER LOGRO RESTABLECIDO');
          achievement.n = Achievements.allAchievements[achievement.id].n;
          _localDB.setLogro(achievement, false);
        }
      }
    });
  }

  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4
  // MIGRACION BASE DE DATOS 1.4.3 A 1.4.4

  Future<bool> updateAllAchievementsData(String uid, Map achievements) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(uid);
    userRef.set({
      'achievements': achievements,
    }, SetOptions(merge: true));
    return true;
  }

  ////////////////////////////////////////
  ////////////////////////////////////////
  ////////////////////////////////////////

  Future<bool> updateAchievementData(
      String uid, String achievement, bool condition) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference userRef = _db.collection(COLLECTION_USERS).doc(uid);
    print('HOLA USUARIO $uid');
    userRef.set({
      'achievements': {
        '$achievement': condition,
      },
    }, SetOptions(merge: true));
    return true;
  }
}
