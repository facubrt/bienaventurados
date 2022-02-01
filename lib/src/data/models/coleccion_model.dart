import 'package:hive/hive.dart';

part 'coleccion_model.g.dart';

@HiveType(typeId: 1)
class Coleccion {
  @HiveField(0)
  int dia;
  @HiveField(1)
  int mes;
  @HiveField(2)
  String titulo;
  @HiveField(3)
  String img;
  @HiveField(4)
  String tipo;
  @HiveField(5)
  String descripcion;
  @HiveField(6)
  bool desbloqueado;

  Coleccion({

    required this.dia,
    required this.mes,
    required this.titulo, 
    required this.img,
    required this.tipo,
    required this.descripcion,
    required this.desbloqueado,
  });
}