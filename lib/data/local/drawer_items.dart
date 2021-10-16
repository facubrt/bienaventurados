import 'package:bienaventurados/models/drawer_item_model.dart';

class DrawerItems {
  static const inicio = DrawerItemModel(titulo: 'Inicio');
  static const perfil = DrawerItemModel(titulo: 'Perfil');
  static const configuraciones = DrawerItemModel(titulo: 'Config');

  static final List<DrawerItemModel> paginas = [
    inicio,
    perfil,
    configuraciones,
  ];
}