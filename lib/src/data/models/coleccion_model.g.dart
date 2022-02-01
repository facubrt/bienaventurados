// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coleccion_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColeccionAdapter extends TypeAdapter<Coleccion> {
  @override
  final int typeId = 1;

  @override
  Coleccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coleccion(
      dia: fields[0] as int,
      mes: fields[1] as int,
      titulo: fields[2] as String,
      img: fields[3] as String,
      tipo: fields[4] as String,
      descripcion: fields[5] as String,
      desbloqueado: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Coleccion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dia)
      ..writeByte(1)
      ..write(obj.mes)
      ..writeByte(2)
      ..write(obj.titulo)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.tipo)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.desbloqueado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColeccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
