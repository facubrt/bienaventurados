import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/models/models.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/configuraciones_page.dart';
import 'package:bienaventurados/src/views/pages/construir/construir_page.dart';
import 'package:bienaventurados/src/views/pages/today/today_page.dart';
import 'package:bienaventurados/src/views/pages/guardados/guardados_page.dart';
import 'package:bienaventurados/src/views/pages/perfil/perfil_page.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/views/pages/dashboard/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isDragging = false;
  final prefs = UserPreferences();
  DrawerItemModel page = DrawerItems.todayPage;
  int? conection;
  int? lastConection;
  String? appVersion;
  //bool _coleccionDesbloqueada = false;

  @override
  void initState() {
    super.initState();
    conectionCheck();
  }

  void conectionCheck() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final avioncitoProvider = Provider.of<PaperplaneProvider>(context, listen: false);
    final coleccionesProvider = Provider.of<CollectionProvider>(context, listen: false);
    final logroProvider = Provider.of<AchievementProvider>(context, listen: false);
    appVersion = await getAppVersion();
    conection = DateTime.now().day.toInt();
    lastConection = prefs.lastConnection;
    if (prefs.appVersion != appVersion) {
      prefs.appVersion = appVersion;
      print('ESTAS USANDO LA VERSION ${prefs.appVersion}');
    }
    if (lastConection != null) {
      if (conection == lastConection) {
        print('MISMO DIA');
        //_coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await avioncitoProvider.isToday();
        await coleccionesProvider.getCollectibleUnlocked();
        logroProvider.openAchievements();
        await coleccionesProvider.openCollectionsBox();
        //authProvider.actualizarConstancia(); // PARA PROBAR CONSTANCIA
      } else {
        print('NUEVO DIA');
        //authProvider.updateUserData();
        //infoProvider.actualizarInformacionApp('restaurar');
        final ultimoDia = DateTime(DateTime.now().year, DateTime.now().month, lastConection!);
        final nuevoDia = DateTime(DateTime.now().year, DateTime.now().month, conection!);
        if (ultimoDia.month == nuevoDia.month || ultimoDia.month + 1 == nuevoDia.month) {
          if (ultimoDia.day + 1 == nuevoDia.day || 1 == nuevoDia.day) {
            print('CONSTANCIA AUMENTADA');
            logroProvider.achievementsCheck('constancia');
            authProvider.increaseConstancy = true;
            //authProvider.actualizarConstancia();
          } else {
            print('CONSTANCIA RESTABLECIDA');
            logroProvider.restoreConstancy();
            authProvider.restartConstancy = true;
          }
        }
        prefs.lastConnection = conection;
        await avioncitoProvider.isNewDay();
        coleccionesProvider.openCollectionsBox();
        logroProvider.openAchievements();
        coleccionesProvider.collectionsCheck();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.lastConnection = conection;
      await avioncitoProvider.firstTime();
      coleccionesProvider.getAllCollections();
      logroProvider.iniciarLogros();
      coleccionesProvider.collectionsCheck();
      logroProvider.achievementsCheck('primer-inicio');
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Scaffold(
      body: Stack(children: [
        drawerProvider.pagesLoaded ? buildDrawer() : CircularProgressIndicator(),
        buildShadow(),
        buildPage(),
      ]),
    );
  }

  Widget buildDrawer() {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    page = drawerProvider.page;
    return SafeArea(
      child: DrawerWidget(
        onSelectedItem: (page) {
          drawerProvider.page = page;
          drawerProvider.closeDrawer();
        },
      ),
    );
  }

  Widget buildPage() {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    drawerProvider.pagesLoaded = true;
    return WillPopScope(
      onWillPop: () async {
        if (drawerProvider.isDrawerOpen) {
          drawerProvider.closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: drawerProvider.closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;

          const delta = 7;
          if (details.delta.dx > delta) {
            drawerProvider.openDrawer();
          } else if (details.delta.dx < -delta) {
            drawerProvider.closeDrawer();
          }

          isDragging = false;
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: DURATION_MS),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(drawerProvider.xOffset, drawerProvider.yOffset, 0)..scale(drawerProvider.scaleFactor),
          child: AbsorbPointer(
              absorbing: drawerProvider.isDrawerOpen,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: DURATION_MS),
                decoration: drawerProvider.isDrawerOpen
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(width: BORDER_WIDTH, color: Theme.of(context).primaryColorDark))
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
    final drawerProvider = Provider.of<DrawerProvider>(context);
    drawerProvider.pagesLoaded = true;
    return AnimatedContainer(
      duration: Duration(milliseconds: DURATION_MS),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(drawerProvider.xOffset - 10, drawerProvider.yOffset + 26, 0)..scale(drawerProvider.scaleFactor - 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
      ),
    );
  }

  Widget getDrawerPage() {
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    switch (drawerProvider.page) {
      case DrawerItems.todayPage:
        return TodayPage();
      case DrawerItems.savedPage:
        return GuardadosPage();
      case DrawerItems.buildPage:
        return ConstruirPage();
      case DrawerItems.profilePage:
        return PerfilPage();
      case DrawerItems.configPage:
        return ConfiguracionesPage();
      default:
        return TodayPage();
    }
  }
}
