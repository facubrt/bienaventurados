import 'package:bienaventurados/data/local/drawer_items.dart';
import 'package:bienaventurados/models/drawer_item_model.dart';
import 'package:bienaventurados/pages/configuraciones/configuraciones_page.dart';
import 'package:bienaventurados/pages/inicio/inicio_page.dart';
import 'package:bienaventurados/pages/perfil/perfil_page.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/widgets/inicio/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDragging = false;
  late bool isDrawerOpen;
  final LocalNotifications noti = LocalNotifications();
  late SharedPreferences prefs;
  bool _activarNotificaciones = true;
  DrawerItemModel pagina = DrawerItems.inicio;
  late bool _paginasCargadas;

  @override
  void initState() {
    super.initState();
    _paginasCargadas = false;
    closeDrawer();
    noti.init();
    if (_activarNotificaciones) {
      print('notificaciones activadas');
      noti.scheduleDaily9AMNotification(9);
    } else {
      print('notificaciones desactivadas');
    }
    // final avioncitoProvider =
    //     Provider.of<AvioncitoProvider>(context, listen: false);
    // avioncitoProvider.configuracionInicial();
  }

  void obtenerPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _activarNotificaciones = prefs.getBool('activarNotificaciones') ?? true;
  }

  void openDrawer() => setState(() {
        xOffset = 280;
        yOffset = 80;
        scaleFactor = 0.8;
        isDrawerOpen = true;
      });

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _paginasCargadas ? buildDrawer() : CircularProgressIndicator(),
        buildPage()
      ]),
    );
  }

  Widget buildDrawer() =>
      SafeArea(child: DrawerWidget(onSelectedItem: (pagina) {
        setState(() => this.pagina = pagina);
        closeDrawer();
      }));

  Widget buildPage() {
    setState(() {
      _paginasCargadas = true;
    });
    return WillPopScope(
      onWillPop: () async {
        if (!isDrawerOpen) {
          closeDrawer();

          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;

          const delta = 7;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }

          isDragging = false;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          child: AbsorbPointer(
              absorbing: isDrawerOpen,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                  border: isDrawerOpen
                      ? Border.all(
                          width: 4, color: Theme.of(context).primaryColorDark)
                      : Border.all(width: 0),
                ),
                child: getDrawerPage(),
              )),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (pagina) {
      case DrawerItems.inicio:
        return InicioPage(openDrawer: openDrawer);
      case DrawerItems.perfil:
        return PerfilPage(openDrawer: openDrawer);
      case DrawerItems.configuraciones:
        return ConfiguracionesPage(openDrawer: openDrawer);
      default:
        return InicioPage(openDrawer: openDrawer);
    }
  }
}
