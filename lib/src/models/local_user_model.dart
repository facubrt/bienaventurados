import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'local_user_model.g.dart';

@HiveType(typeId: 3)
class LocalUser with ChangeNotifier {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? email;
  @HiveField(3)
  // CLASE Y TIPO
  String? role;
  @HiveField(4)
  String? type;
  @HiveField(5)
  int? level;
  // ESTADISTICAS
  @HiveField(6)
  int? totalXP;
  @HiveField(7)
  int? action;
  @HiveField(8)
  int? formation;
  @HiveField(9)
  int? devotion;
  @HiveField(10)
  int? prayer;
  @HiveField(11)
  int? pplanesBuilded;
  @HiveField(12)
  int? pplanesShared;
  @HiveField(13)
  int? constancy;
  @HiveField(14)
  int? bestConstancy;
  // CONNECTION
  @HiveField(15)
  String? firstConnection;
  @HiveField(16)
  String? lastConnection;

  LocalUser({
    this.uid,
    this.username,
    this.email,
    this.role,
    this.type,
    this.level,
    this.totalXP,
    this.action,
    this.formation,
    this.devotion,
    this.prayer,
    this.pplanesBuilded,
    this.pplanesShared,
    this.constancy,
    this.bestConstancy,
    this.firstConnection,
    this.lastConnection,
  });

  factory LocalUser.fromFirestore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data()! as Map;
    return LocalUser(
      uid: userDoc.id,
      username: userData['username'],
      email: userData['email'],
      role: userData['role'] ?? 'bienaventurado',
      type: userData['type'] ?? 'bienaventurado',
      level: userData['level'] ?? 1,
      totalXP: userData['stats']['total-xp'] ?? 0,
      action: userData['stats']['action'] ?? 0,
      formation: userData['stats']['formation'] ?? 0,
      devotion: userData['stats']['devotion'] ?? 0,
      prayer: userData['stats']['prayer'] ?? 0,
      pplanesBuilded: userData['stats']['pplanes-builded'] ?? 0,
      pplanesShared: userData['stats']['pplanes-shared'] ?? 0,
      constancy: userData['stats']['constancy'] ?? 1,
      bestConstancy: userData['stats']['best-constancy'] ?? 1,
      firstConnection: userData['connection']['firstConnection'],
      lastConnection: userData['connection']['lastConnection'],
    );
  }

  void setFromFirestore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data()! as Map;
    print(
        'LAS ESTADISTICAS SON ${userData['stats']} Y LOS AV COMPARTIDOS ${userData['stats']['pplanes-shared']}');
    uid = userDoc.id;
    username = userData['username'];
    email = userData['email'];
    role = userData['role'] ?? 'bienaventurado';
    type = userData['type'] ?? 'bienaventurado';
    level = userData['level'] ?? 1;
    totalXP = userData['stats']['total-xp'] ?? 0;
    action = userData['stats']['action'] ?? 0;
    formation = userData['stats']['formation'] ?? 0;
    devotion = userData['stats']['devotion'] ?? 0;
    prayer = userData['stats']['prayer'] ?? 0;
    pplanesBuilded = userData['stats']['pplanes-builded'] ?? 0;
    pplanesShared = userData['stats']['pplanes-shared'] ?? 0;
    constancy = userData['stats']['constancy'] ?? 1;
    bestConstancy = userData['stats']['best-constancy'] ?? 1;
    firstConnection = userData['connection']['firstConnection'].toString();
    lastConnection = userData['connection']['lastConnection'].toString();
    print('SE CARGO $pplanesShared AV COMPARTIDOS');
    notifyListeners();
  }
}
