import 'package:bienaventurados/src/data/models/drawer_item_model.dart';
import 'package:iconsax/iconsax.dart';

class DrawerItems {
  static const inicio = DrawerItemModel(titulo: 'Hoy', icon: Iconsax.home);
  static const guardados = DrawerItemModel(titulo: 'Guardados', icon: Iconsax.save_2);
  static const construir = DrawerItemModel(titulo: 'Construir', icon: Iconsax.add_square);
  static const perfil = DrawerItemModel(titulo: 'Perfil', icon: Iconsax.profile_circle);
  static const division = DrawerItemModel(titulo: 'Division', icon: Iconsax.note);
  static const configuraciones = DrawerItemModel(titulo: 'Config.', icon: Iconsax.setting_2);
  static const salir = DrawerItemModel(titulo: 'Salir', icon: Iconsax.logout);


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