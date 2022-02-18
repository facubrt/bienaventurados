import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String? uid;
  final DateTime? ultimaConexion;
  final String? nombre;
  final String? correo;
  final String? clase;

  Usuario({
    this.uid,
    this.ultimaConexion,
    this.nombre,
    this.correo,
    this.clase,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

}