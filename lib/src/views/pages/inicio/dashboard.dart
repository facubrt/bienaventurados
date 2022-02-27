import 'package:bienaventurados/src/data/datasources/local/drawer_items.dart';
import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/models/drawer_item_model.dart';
import 'package:bienaventurados/src/logic/providers/providers.dart';
import 'package:bienaventurados/src/logic/services/local_notifications.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/configuraciones_page.dart';
import 'package:bienaventurados/src/views/pages/construir/construir_page.dart';
import 'package:bienaventurados/src/views/pages/inicio/inicio_page.dart';
import 'package:bienaventurados/src/views/pages/guardados/guardados_page.dart';
import 'package:bienaventurados/src/views/pages/perfil/perfil_page.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/views/widgets/inicio/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final prefs = PreferenciasUsuario();
  DrawerItemModel pagina = DrawerItems.inicio;
  late bool _paginasCargadas;
  int? _actualConexion;
  int? _ultimaConexion;
  String? _versionApp;
  bool _coleccionDesbloqueada = false;

  @override
  void initState() {
    _paginasCargadas = false;
    closeDrawer();
    comprobacionDia();
    super.initState();
  }

    void comprobacionDia() async {
    //final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context, listen: false);
    final logroProvider = Provider.of<LogroProvider>(context, listen: false);
    _actualConexion = DateTime.now().day.toInt();
    _ultimaConexion = prefs.ultimaConexion;
    _versionApp = prefs.versionApp;
    //print(_versionApp);
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('MISMO DIA');
        _coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await avioncitoProvider.mismoAvioncito();
        await coleccionesProvider.getColeccionDesbloqueada();
        logroProvider.abrirLogros();
        await coleccionesProvider.abrirColecciones();
        //authProvider.actualizarConstancia(); // PARA PROBAR CONSTANCIA
      } else {
        print('NUEVO DIA');
        //authProvider.updateUserData();
        //infoProvider.actualizarInformacionApp('restaurar');
        final ultimoDia = DateTime(DateTime.now().year, DateTime.now().month, _ultimaConexion!);
        final nuevoDia = DateTime(DateTime.now().year, DateTime.now().month, _actualConexion!);
        if (ultimoDia.month == nuevoDia.month || ultimoDia.month + 1 == nuevoDia.month) {
          if (ultimoDia.day + 1 == nuevoDia.day || 1 == nuevoDia.day) {
            //print('CONSTANCIA AUMENTADA');
            logroProvider.comprobacionLogros('constancia');
            authProvider.actualizarConstancia();
          } else {
            //print('CONSTANCIA RESTABLECIDA');
            logroProvider.restablecerConstancia();
            authProvider.constanciaRestablecida = true;
          }
        }
        prefs.ultimaConexion = _actualConexion;
        await avioncitoProvider.nuevoAvioncito();
        coleccionesProvider.abrirColecciones();
        logroProvider.abrirLogros();
        coleccionesProvider.comprobacionColecciones();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _actualConexion;
      await avioncitoProvider.primerInicio();
      coleccionesProvider.crearColecciones();
      logroProvider.iniciarLogros();
      coleccionesProvider.comprobacionColecciones();
      logroProvider.comprobacionLogros('Primer Inicio');
    }
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
        buildShadow(),
        buildPage(),
      ]),
    );
  }

  Widget buildDrawer() {
    return SafeArea(child: DrawerWidget(onSelectedItem: (pagina) {
      setState(() => this.pagina = pagina);
      closeDrawer();
    }));
  }

  Widget buildPage() {
    setState(() {
      _paginasCargadas = true;
    });
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
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
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
              absorbing: isDrawerOpen,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 200),
                decoration: isDrawerOpen
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(width: 4, color: Theme.of(context).primaryColorDark))
                    : BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                child: getDrawerPage(),
              )),
        ),
      ),
    );
  }

  Widget buildShadow() {
    setState(() {
      _paginasCargadas = true;
    });
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(xOffset - 10, yOffset + 26, 0)..scale(scaleFactor - 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (pagina) {
      case DrawerItems.inicio:
        return InicioPage(openDrawer: openDrawer);
      case DrawerItems.guardados:
        return GuardadosPage(openDrawer: openDrawer);
      case DrawerItems.construir:
        return ConstruirPage(openDrawer: openDrawer);
      case DrawerItems.perfil:
        return PerfilPage(openDrawer: openDrawer);
      case DrawerItems.configuraciones:
        return ConfiguracionesPage(openDrawer: openDrawer);
      default:
        return InicioPage(openDrawer: openDrawer);
    }
  }
}
