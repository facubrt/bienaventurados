import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/models/drawer_item_model.dart';
import 'package:flutter/cupertino.dart';

class DrawerProvider with ChangeNotifier {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool _isDrawerOpen = false;
  bool pagesLoaded = false;
  DrawerItemModel page = DrawerItems.todayPage;

  void openDrawer() {
    xOffset = 280;
    yOffset = 80;
    scaleFactor = 0.8;
    _isDrawerOpen = true;
    notifyListeners();
  }

  void setPage(newPage) {
    page = newPage;
    notifyListeners();
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    _isDrawerOpen = false;
    notifyListeners();
  }

  bool get isDrawerOpen => _isDrawerOpen;
}
