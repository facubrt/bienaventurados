import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'avioncito_model.g.dart';

@HiveType(typeId: 0)
class Avioncito extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String? id;
  @HiveField(1)
  DateTime? fecha;
  @HiveField(2)
  String? frase;
  @HiveField(3)
  String? santo;
  @HiveField(4)
  String? reflexion;
  @HiveField(5)
  String? tag;
  @HiveField(5)
  String? pregunta;
  @HiveField(5)
  String? mision;
  @HiveField(6)
  String? usuario;
  @HiveField(7)
  bool? guardado;
  @HiveField(8)
  bool? visto = false;

  Avioncito(
    {
      this.id,
      this.fecha,
      this.frase,
      this.santo,
      this.reflexion,
      this.tag,
      this.pregunta,
      this.mision,
      this.usuario,
      this.guardado,
      this.visto});

  factory Avioncito.fromFirestore(DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    return Avioncito(
      id: avioncitoDoc.id,
      fecha: DateTime.now(),
      frase: avioncitoData['frase'],
      santo: avioncitoData['santo'],
      reflexion: avioncitoData['reflexion'],
      tag: avioncitoData['tag'],
      pregunta: avioncitoData['pregunta'],
      mision: avioncitoData['mision'],
      usuario: avioncitoData['usuario'],
      guardado: false,
    );
  }

    void setFromFirestore (DocumentSnapshot avioncitoDoc) {
    Map avioncitoData = avioncitoDoc.data()! as Map;
    id = avioncitoDoc.id;
    fecha = DateTime.now();
    frase = avioncitoData['frase'];
    santo = avioncitoData['santo'];
    reflexion = avioncitoData['reflexion'];
    tag = avioncitoData['tag'];
    pregunta = avioncitoData['pregunta'];
    mision = avioncitoData['mision'];
    usuario = avioncitoData['usuario'];
    guardado = false;

    notifyListeners(); 
  }

  Avioncito.fromMap(Map<String, dynamic> map) {
    frase = map['frase'];
    santo = map['santo'];
    reflexion = map['reflexion'];
    tag = map['tag'];
    mision = map['mision'];
    pregunta = map['pregunta'];
    usuario = map['usuario'];
    id = map['id'];
    fecha = map['fecha'];
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
      'pregunta': pregunta,
      'mision': mision,
      'usuario': usuario,
      'id': id,
      'fecha': fecha,
      'visto': visto,
      'guardado': guardado
    };
  }
}