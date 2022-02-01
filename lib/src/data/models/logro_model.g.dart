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
      titulo: fields[0] as String,
      img: fields[1] as String,
      descripcion: fields[2] as String,
      desbloqueado: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Logro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.img)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
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
