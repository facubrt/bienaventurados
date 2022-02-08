// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logro_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogroAdapter extends TypeAdapter<Logro> {
  @override
  final int typeId = 2;

  @override
  Logro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Logro(
      id: fields[0] as int,
      titulo: fields[1] as String,
      objetivo: fields[2] as String,
      img: fields[3] as String,
      descripcion: fields[4] as String,
      desbloqueado: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Logro obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.objetivo)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.descripcion)
      ..writeByte(5)
      ..write(obj.desbloqueado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
