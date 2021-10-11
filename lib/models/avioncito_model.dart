import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'avioncito_model.g.dart';

@HiveType(typeId: 0)
class Avioncito extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? frase;
  @HiveField(2)
  String? santo;
  @HiveField(3)
  String? reflexion;
  @HiveField(4)
  String? tag;
  @HiveField(5)
  bool? visto = false;

  Avioncito(
    {
      this.id,
      this.frase,
      this.santo,
      this.reflexion,
      this.tag,
      this.visto});

  factory Avioncito.fromFirestore(DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    return Avioncito(
      frase: avioncitoData['frase'],
      santo: avioncitoData['santo'],
      reflexion: avioncitoData['reflexion'],
      tag: avioncitoData['tag'],
      id: avioncitoDoc.id,
    );
  }

    void setFromFirestore (DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    frase = avioncitoData['frase'];
    santo = avioncitoData['santo'];
    reflexion = avioncitoData['reflexion'];
    tag = avioncitoData['tag'];
    id = avioncitoDoc.id;

    notifyListeners(); 
  }

  Avioncito.fromMap(Map<String, dynamic> map) {
    frase = map['frase'];
    santo = map['santo'];
    reflexion = map['reflexion'];
    tag = map['tag'];
    id = map['id'];
    visto = map['visto'];

    notifyListeners();
  }

  Map<String, dynamic> toMap () {
    return {
      'frase': frase,
      'santo': santo,
      'reflexion': reflexion,
      'tag': tag,
      'id': id,
      'visto': visto,
    };
  }
}