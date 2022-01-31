import 'package:hive/hive.dart';

//part 'Coleccion_model.g.dart';

@HiveType(typeId: 1)
class Coleccion {
  @HiveField(0)
  String titulo;
  @HiveField(1)
  String img;
  @HiveField(2)
  String descripcion;
  @HiveField(3)
  bool desbloqueado;
  @HiveField(4)
  int dia;
  @HiveField(5)
  int mes;

  Coleccion({

    required this.titulo, 
    required this.img,
    required this.descripcion,
    required this.desbloqueado,
    required this.dia,
    required this.mes,
  });
}