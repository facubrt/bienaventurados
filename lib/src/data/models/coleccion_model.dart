import 'package:hive/hive.dart';

part 'coleccion_model.g.dart';

@HiveType(typeId: 1)
class Coleccion {
  @HiveField(0)
  int id;
  @HiveField(1)
  int dia;
  @HiveField(2)
  int mes;
  @HiveField(3)
  String titulo;
  @HiveField(4)
  String img;
  @HiveField(5)
  String tipo;
  @HiveField(6)
  String descripcion;
  @HiveField(7)
  bool desbloqueado;

  Coleccion({
    required this.id,
    required this.dia,
    required this.mes,
    required this.titulo,
    required this.img,
    required this.tipo,
    required this.descripcion,
    required this.desbloqueado,
  });
}
