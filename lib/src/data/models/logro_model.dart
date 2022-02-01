import 'package:hive/hive.dart';

part 'logro_model.g.dart';

@HiveType(typeId: 2)
class Logro {
  @HiveField(0)
  String titulo;
  @HiveField(1)
  String img;
  @HiveField(2)
  String descripcion;
  @HiveField(3)
  bool desbloqueado;

  Logro({

    required this.titulo, 
    required this.img,
    required this.descripcion,
    required this.desbloqueado,
  });
}