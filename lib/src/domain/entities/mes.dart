import 'package:equatable/equatable.dart';

class Mes extends Equatable {
  final String id;
  final int numero;

  Mes({required this.id, required this.numero});

  @override
  List<Object?> get props => throw UnimplementedError();
}