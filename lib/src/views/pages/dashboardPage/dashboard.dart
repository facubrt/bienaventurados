import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/models/models.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/views/pages/configPage/config_page.dart';
import 'package:bienaventurados/src/views/pages/buildPage/build_page.dart';
import 'package:bienaventurados/src/views/pages/todayPage/today_page.dart';
import 'package:bienaventurados/src/views/pages/savedPage/saved_page.dart';
import 'package:bienaventurados/src/views/pages/profilePage/profile_page.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/views/pages/dashboardPage/widgets/drawer_widget.dart';
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
    final paperplaneProvider =
        Provider.of<PaperplaneProvider>(context, listen: false);
    final collectionProvider =
        Provider.of<CollectionProvider>(context, listen: false);
    final achievementProvider =
        Provider.of<AchievementProvider>(context, listen: false);
    appVersion = '1.4.4B'; //await getAppVersion();
    conection = DateTime.now().day.toInt();
    lastConection = prefs.lastConnection;
    print('ESTAS USANDO LA VERSION ${prefs.appVersion}');
    if (prefs.appVersion != appVersion) {
      //TODO 1.4.4 - PASO 1 - MIGRATE PAPERPLANES
      // paperplaneProvider.migratePaperplanesDB().then((result) {
      //   if (result) {
      //     print('AVIONCITOS TRANFERIDOS');
      //   } else {
      //     print('NO SE TRANSFIRIERON LOS AVIONCITOS');
      //   }
      // });

      //TODO 1.4.4 - PASO 2 - MIGRATE USERS
      // print('INICIANDO MIGRACION DE USUARIOS');
      // authProvider.migrateUsersDB().then((result) {
      //   if (result) {
      //     print('USUARIOS MIGRADOS CORRECTAMENTE');
      //   } else {
      //     print('ERROR');
      //   }
      // });

      //CUANDO SE DESBLOQUEA UN LOGRO O COLECCIONALBE
      //UPDATE COLLECTION
      // authProvider.updateCollectionData('saint-joseph', true).then((result) {
      //   if (result) {
      //     print('DATOS DE COLECCION ACTUALIZADOS');
      //   } else {
      //     print('ERROR');
      //   }
      // });

      //prefs.appVersion = appVersion;
    }
    if (lastConection != null) {
      if (conection == lastConection) {
        print('MISMO DIA');
        //_coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await paperplaneProvider.isToday();
        await collectionProvider.getCollectibleUnlocked();
        achievementProvider.openAchievements();
        await collectionProvider.openCollectionsBox();
        // print('CONSTANCIA AUMENTADA'); // PARA PROBAR CONSTANCIA
        // achievementProvider.achievementsCheck('constancia'); // PARA PROBAR CONSTANCIA
        // authProvider.increaseConstancy = true; // PARA PROBAR CONSTANCIA
      } else {
        print('NUEVO DIA');
        //authProvider.updateUserData();
        //infoProvider.actualizarInformacionApp('restaurar');
        final lastDay =
            DateTime(DateTime.now().year, DateTime.now().month, lastConection!);
        final newDay =
            DateTime(DateTime.now().year, DateTime.now().month, conection!);
        if (lastDay.month == newDay.month ||
            lastDay.month + 1 == newDay.month) {
          if (lastDay.day + 1 == newDay.day || 1 == newDay.day) {
            print('CONSTANCIA AUMENTADA');
            achievementProvider.achievementsCheck('constancia');
            authProvider.increaseConstancy = true;
            //authProvider.actualizarConstancia();
          } else {
            print('CONSTANCIA RESTABLECIDA');
            achievementProvider.restoreConstancy();
            authProvider.restartConstancy = true;
          }
        }
        prefs.lastConnection = conection;
        await paperplaneProvider.isNewDay();
        collectionProvider.openCollectionsBox();
        achievementProvider.openAchievements();
        collectionProvider.collectionsCheck();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.lastConnection = conection;
      await paperplaneProvider.firstTime();
      collectionProvider.getAllCollections();
      achievementProvider.initAchievements();
      collectionProvider.collectionsCheck();
      achievementProvider.achievementsCheck('primer-inicio');
    }
  }

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Scaffold(
      body: Stack(children: [
        drawerProvider.pagesLoaded
            ? buildDrawer()
            : CircularProgressIndicator(),
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
          transform: Matrix4.translationValues(
              drawerProvider.xOffset, drawerProvider.yOffset, 0)
            ..scale(drawerProvider.scaleFactor),
          child: AbsorbPointer(
              absorbing: drawerProvider.isDrawerOpen,
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: DURATION_MS),
                decoration: drawerProvider.isDrawerOpen
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                            width: BORDER_WIDTH,
                            color: Theme.of(context).primaryColorDark))
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
      transform: Matrix4.translationValues(
          drawerProvider.xOffset - 10, drawerProvider.yOffset + 26, 0)
        ..scale(drawerProvider.scaleFactor - 0.06),
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
        return SavedPage();
      case DrawerItems.buildPage:
        return BuildPage();
      case DrawerItems.profilePage:
        return ProfilePage();
      case DrawerItems.configPage:
        return ConfigPage();
      default:
        return TodayPage();
    }
  }
}
