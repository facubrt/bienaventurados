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
  String? usuario;
  @HiveField(6)
  bool? guardado;
  @HiveField(7)
  bool? visto = false;

  Avioncito(
    {
      this.id,
      this.frase,
      this.santo,
      this.reflexion,
      this.tag,
      this.usuario,
      this.guardado,
      this.visto});

  factory Avioncito.fromFirestore(DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    return Avioncito(
      frase: avioncitoData['frase'],
      santo: avioncitoData['santo'],
      reflexion: avioncitoData['reflexion'],
      tag: avioncitoData['tag'],
      usuario: avioncitoData['usuario'],
      id: avioncitoDoc.id,
      guardado: false,
    );
  }

    void setFromFirestore (DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    frase = avioncitoData['frase'];
    santo = avioncitoData['santo'];
    reflexion = avioncitoData['reflexion'];
    tag = avioncitoData['tag'];
    usuario = avioncitoData['usuario'];
    id = avioncitoDoc.id;
    guardado = false;

    notifyListeners(); 
  }

  Avioncito.fromMap(Map<String, dynamic> map) {
    frase = map['frase'];
    santo = map['santo'];
    reflexion = map['reflexion'];
    tag = map['tag'];
    usuario = map['usuario'];
    id = map['id'];
    visto = map['visto'];
    guardado = map['guardado'];

    notifyListeners();
  }

  Map<String, dynamic> toMap () {
    return {
      'frase': frase,
      'santo': santo,
      'reflexion': reflexion,
      'tag': tag,
      'usuario': usuario,
      'id': id,
      'visto': visto,
      'guardado': guardado
    };
  }
}