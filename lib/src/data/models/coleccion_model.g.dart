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
      id: fields[0] as int,
      dia: fields[1] as int,
      mes: fields[2] as int,
      titulo: fields[3] as String,
      img: fields[4] as String,
      tipo: fields[5] as String,
      descripcion: fields[6] as String,
      desbloqueado: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Coleccion obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dia)
      ..writeByte(2)
      ..write(obj.mes)
      ..writeByte(3)
      ..write(obj.titulo)
      ..writeByte(4)
      ..write(obj.img)
      ..writeByte(5)
      ..write(obj.tipo)
      ..writeByte(6)
      ..write(obj.descripcion)
      ..writeByte(7)
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
