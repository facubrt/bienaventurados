
import 'package:equatable/equatable.dart';

class Avioncito extends Equatable {

  final String? id;
  final DateTime? fecha;
  final String? frase;
  final String? santo;
  final String? reflexion;
  final String? tag;
  final String? pregunta;
  final String? mision;
  final String? usuario;
  final bool? guardado;
  final bool? visto;

  Avioncito(
    {
      this.id,
      this.fecha,
      this.frase,
      this.santo,
      this.reflexion,
      this.tag,
      this.pregunta,
      this.mision,
      this.usuario,
      this.guardado,
      this.visto,
    }
  );

  @override
  List<Object?> get props => throw UnimplementedError();
}