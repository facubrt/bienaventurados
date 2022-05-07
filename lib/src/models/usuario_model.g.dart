// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsuarioAdapter extends TypeAdapter<Usuario> {
  @override
  final int typeId = 3;

  @override
  Usuario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usuario(
      uid: fields[0] as String?,
      ultimaConexion: fields[1] as String?,
      nombre: fields[2] as String?,
      correo: fields[3] as String?,
      clase: fields[4] as String?,
      avCompartidos: fields[5] as int?,
      avConstruidos: fields[6] as int?,
      actualConstancia: fields[7] as int?,
      mejorConstancia: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.ultimaConexion)
      ..writeByte(2)
      ..write(obj.nombre)
      ..writeByte(3)
      ..write(obj.correo)
      ..writeByte(4)
      ..write(obj.clase)
      ..writeByte(5)
      ..write(obj.avCompartidos)
      ..writeByte(6)
      ..write(obj.avConstruidos)
      ..writeByte(7)
      ..write(obj.actualConstancia)
      ..writeByte(8)
      ..write(obj.mejorConstancia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsuarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
