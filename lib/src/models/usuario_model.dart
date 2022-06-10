import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'usuario_model.g.dart';

@HiveType(typeId: 3)
class Usuario with ChangeNotifier {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? ultimaConexion;
  @HiveField(2)
  String? nombre;
  @HiveField(3)
  String? correo;
  @HiveField(4)
  String? clase;
  // Estadisticas
  @HiveField(5)
  int? avCompartidos;
  @HiveField(6)
  int? avConstruidos;
  @HiveField(7)
  int? actualConstancia;
  @HiveField(8)
  int? mejorConstancia;

  Usuario({
    this.uid,
    this.ultimaConexion,
    this.nombre,
    this.correo,
    this.clase,
    this.avCompartidos,
    this.avConstruidos,
    this.actualConstancia,
    this.mejorConstancia,
  });

  factory Usuario.fromFirestore(DocumentSnapshot usuarioDoc) {
    Map usuarioData = usuarioDoc.data()! as Map;
    return Usuario(
      uid: usuarioDoc.id,
      nombre: usuarioData['nombre'],
      ultimaConexion: usuarioData['ultimaConexion'],
      correo: usuarioData['correo'],
      clase: usuarioData['clase'],
      avCompartidos: usuarioData['av-construidos'] ?? 0,
      avConstruidos: usuarioData['av-construidos'] ?? 0,
      actualConstancia: usuarioData['actual-constancia'] ?? 1,
      mejorConstancia: usuarioData['mejor-constancia'] ?? 1,
    );
  }

  void setFromFirestore(DocumentSnapshot usuarioDoc) {
    Map usuarioData = usuarioDoc.data()! as Map;
    uid = usuarioDoc.id;
    nombre = usuarioData['username'];
    correo = usuarioData['email'];
    ultimaConexion = usuarioData['connection']['lastconnection'].toString();
    clase = usuarioData['type'];
    avConstruidos = usuarioData['stats']['pplanes-builded'] ?? 0;
    avCompartidos = usuarioData['stats']['pplanes-shared'] ?? 0;
    actualConstancia = usuarioData['stats']['constancy'] ?? 1;
    mejorConstancia = usuarioData['stats']['best-constancy'] ?? 1;
    notifyListeners();
  }
}
