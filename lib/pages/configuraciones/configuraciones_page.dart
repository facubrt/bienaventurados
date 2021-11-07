import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracionesPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const ConfiguracionesPage({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  State<ConfiguracionesPage> createState() => _ConfiguracionesPageState();
}

class _ConfiguracionesPageState extends State<ConfiguracionesPage> {
  late SharedPreferences prefs;
  // late bool _activarModoNoche;
  // int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final LocalNotifications noti = LocalNotifications();
    // ThemeProvider themeProvider = Provider.of<ThemeProvider>(
    //   context,
    //   listen: false,
    // );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: () {
              widget.openDrawer();
            },
            icon: Icon(FlutterIcons.menu_fea, size: MediaQuery.of(context).size.width * 0.06),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(notificacionesConfiguracionPage);
                  
                },
                child: Text('Notificaciones',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ))),
            SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
            InkWell(
              onTap: () {
                
                Navigator.of(context).pushNamed(temaConfiguracionPage);
              },
              child: Text(
                'Cambiar tema',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(informacionPage);
              },
              child: Text(
                'Acerca de',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'Carlo Acutis (beato) ver 1.3.0'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.024,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
