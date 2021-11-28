import 'package:bienaventurados/models/drawer_item_model.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DrawerItems {
  static const inicio = DrawerItemModel(titulo: 'Hoy', icon: FlutterIcons.compass_fea);
  static const guardados = DrawerItemModel(titulo: 'Guardados', icon: FlutterIcons.bookmark_fea);
  static const construir = DrawerItemModel(titulo: 'Construir', icon: FlutterIcons.plus_circle_fea);
  static const perfil = DrawerItemModel(titulo: 'Perfil', icon: FlutterIcons.user_fea);
  static const division = DrawerItemModel(titulo: 'Division', icon: FlutterIcons.log_out_fea);
  static const configuraciones = DrawerItemModel(titulo: 'Config.', icon: FlutterIcons.settings_fea);
  static const salir = DrawerItemModel(titulo: 'Salir', icon: FlutterIcons.log_out_fea);


  static final List<DrawerItemModel> paginas = [
    inicio,
    guardados,
    construir,
    perfil,
    division,
    configuraciones,
    //salir,
  ];
}