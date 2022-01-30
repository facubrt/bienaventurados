import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Usuario with ChangeNotifier {
  String? uid;
  Timestamp? ultimaConexion;
  String? nombre;
  String? correo;
  String? clase;

  Usuario({
    this.uid,
    this.ultimaConexion,
    this.nombre,
    this.correo,
    this.clase,
  });

  factory Usuario.fromFirestore(DocumentSnapshot usuarioDoc) {
    Map usuarioData = usuarioDoc.data()! as Map;
    return Usuario(
      uid: usuarioDoc.id,
      nombre: usuarioData['nombre'],
      ultimaConexion: usuarioData['ultimaConexion'],
      correo: usuarioData['correo'],
      clase: usuarioData['clase']
    );
  }

  void setFromFirestore (DocumentSnapshot usuarioDoc){
    Map usuarioData = usuarioDoc.data()! as Map;
    uid = usuarioDoc.id;
    nombre = usuarioData['nombre'];
    correo = usuarioData['correo'];
    ultimaConexion = usuarioData['ultimaConexion'];
    clase = usuarioData['clase'];
    notifyListeners();
  }

}
