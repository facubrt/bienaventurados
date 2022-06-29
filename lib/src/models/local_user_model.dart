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
  String? img;
  @HiveField(5)
  String? type;
  @HiveField(6)
  int? level;
  // ESTADISTICAS
  @HiveField(7)
  int? totalXP;
  @HiveField(8)
  int? action;
  @HiveField(9)
  int? formation;
  @HiveField(10)
  int? devotion;
  @HiveField(11)
  int? prayer;
  @HiveField(12)
  int? pplanesBuilded;
  @HiveField(13)
  int? pplanesShared;
  @HiveField(14)
  int? constancy;
  @HiveField(15)
  int? bestConstancy;
  // CONNECTION
  @HiveField(16)
  String? firstConnection;
  @HiveField(17)
  String? lastConnection;

  LocalUser({
    this.uid,
    this.username,
    this.email,
    this.role,
    this.img,
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
      img: userData['img'] ?? 'perfil-01',
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

    uid = userDoc.id;
    username = userData['username'];
    email = userData['email'];
    role = userData['role'] ?? 'bienaventurado';
    img = userData['img'] ?? 'perfil-01';
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
    notifyListeners();
  }
}
