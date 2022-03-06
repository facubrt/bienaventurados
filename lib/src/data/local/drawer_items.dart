import 'package:bienaventurados/src/models/drawer_item_model.dart';
import 'package:iconsax/iconsax.dart';

class DrawerItems {
  static const todayPage = DrawerItemModel(title: 'Hoy', icon: Iconsax.home);
  static const savedPage = DrawerItemModel(title: 'Guardados', icon: Iconsax.save_2);
  static const buildPage = DrawerItemModel(title: 'Construir', icon: Iconsax.add_square);
  static const profilePage = DrawerItemModel(title: 'Perfil', icon: Iconsax.profile_circle);
  static const division = DrawerItemModel(title: 'Division', icon: Iconsax.note);
  static const configPage = DrawerItemModel(title: 'Config.', icon: Iconsax.setting_2);


  static final List<DrawerItemModel> allPages = [
    todayPage,
    savedPage,
    buildPage,
    profilePage,
    division,
    configPage,
  ];
}