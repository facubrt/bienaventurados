import 'package:bienaventurados/src/data/datasources/local/drawer_items.dart';
import 'package:bienaventurados/src/data/models/drawer_item_model.dart';
import 'package:flutter/cupertino.dart';

class DrawerProvider with ChangeNotifier {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool _isDrawerOpen = false;
  bool _paginasCargadas = false;
  DrawerItemModel _pagina = DrawerItems.inicio;

  void openDrawer() {
    xOffset = 280;
    yOffset = 80;
    scaleFactor = 0.8;
    _isDrawerOpen = true;
    notifyListeners();
  }

  void cambiarPagina(pagina) {
    _pagina = pagina;
  }

  void closeDrawer() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    _isDrawerOpen = false;
    notifyListeners();
  }

  bool get isDrawerOpen => _isDrawerOpen;
  bool get paginasCargadas => _paginasCargadas;
  set paginasCargadas(bool isPaginasCargadas) {
    _paginasCargadas = isPaginasCargadas;
    //notifyListeners();
  }

  DrawerItemModel get pagina => _pagina;
  set pagina(DrawerItemModel pagina) {
    _pagina = pagina;
    notifyListeners();
  }
}
