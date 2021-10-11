import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Usuario with ChangeNotifier {
  String? uid;
  String? ultimaConexion;
  String? nombre;
  String? correo;

  Usuario({
    this.uid,
    this.ultimaConexion,
    this.nombre,
    this.correo,
  });

  factory Usuario.fromFirestore(DocumentSnapshot usuarioDoc) {
    Map usuarioData = usuarioDoc.data()! as Map;
    return Usuario(
      uid: usuarioDoc.id,
      nombre: usuarioData['nombre'],
      //ultimaConexion: usuarioData['ultimaConexion'],
      correo: usuarioData['correo'],
    );
  }

  void setFromFirestore (DocumentSnapshot usuarioDoc){
    Map usuarioData = usuarioDoc.data()! as Map;
    uid = usuarioDoc.id;
    nombre = usuarioData['nombre'];
    correo = usuarioData['correo'];
    //ultimaConexion = usuarioData['ultimaConexion'];
    notifyListeners();
  }

}
