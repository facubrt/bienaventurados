import 'package:hive/hive.dart';

part 'logro_model.g.dart';

@HiveType(typeId: 2)
class Logro {
  @HiveField(0)
  int id;
  @HiveField(1)
  String titulo;
  @HiveField(2)
  String objetivo;
  @HiveField(3)
  String img;
  @HiveField(4)
  String descripcion;
  @HiveField(5)
  bool desbloqueado;
  @HiveField(6)
  int n;
  @HiveField(7)
  int maximo;

  Logro({
    required this.id,
    required this.titulo,
    required this.objetivo,
    required this.img,
    required this.descripcion,
    required this.desbloqueado,
    required this.n,
    required this.maximo,
  });
}
