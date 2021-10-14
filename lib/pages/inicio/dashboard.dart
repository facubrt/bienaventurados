import 'package:bienaventurados/pages/inicio/inicio_page.dart';
import 'package:bienaventurados/providers/local_notifications.dart';
import 'package:bienaventurados/widgets/inicio/drawer_widget.dart';
import 'package:flutter/material.dart';
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
  late bool _paginasCargadas;

  @override
  void initState() {
    super.initState();
    _paginasCargadas=false;
    closeDrawer();
    noti.init();
    if(_activarNotificaciones) {
      print('notificaciones activadas');
      noti.scheduleDaily9AMNotification();
    } else {
      print('notificaciones desactivadas');
    }
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
      body: Stack(
        children: [
          _paginasCargadas ? buildDrawer() : CircularProgressIndicator(), 
          buildPage()
        ]
      ),
      
    );
  }

  Widget buildDrawer() => SafeArea(child: DrawerWidget());

  Widget buildPage(){
    setState(() {
      _paginasCargadas=true;
    });
    return WillPopScope(
      onWillPop: () async {
        if(!isDrawerOpen) {
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
        if(details.delta.dx > delta) {
          openDrawer();
        } else if ( details.delta.dx < -delta) {
          closeDrawer();
        }

        isDragging = false;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: isDrawerOpen ? BoxDecoration(border: Border.all(width: 4, color: Theme.of(context).primaryColorDark)) : BoxDecoration(border: Border.all(width: 0),), 
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
      child: AbsorbPointer(
        absorbing: isDrawerOpen,
        child: Container(
          child: InicioPage(openDrawer: openDrawer),
        )
      ),
      ),),
    );
  } 
}
