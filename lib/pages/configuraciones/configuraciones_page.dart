import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class ConfiguracionesPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const ConfiguracionesPage({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  State<ConfiguracionesPage> createState() => _ConfiguracionesPageState();
}

class _ConfiguracionesPageState extends State<ConfiguracionesPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;
  
  final _listaOpciones = [
    'Notificaciones',
    'Cambiar tema',
    'Calificanos',
    //'Reporta un error',
    'Acerca de',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            widget.openDrawer();
          },
          icon: Icon(FlutterIcons.menu_fea,
              size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: ListView.separated(
        itemCount: _listaOpciones.length,
        itemBuilder: (context, index){
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: MediaQuery.of(context).size.width * 0.04),
                onTap: () {
                  navegarHacia(index);
                },
                title: Text(_listaOpciones[index], style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    )),
              );
        }, 
        separatorBuilder: (context, index){ 
          return Divider(
            height: 0, 
            indent: MediaQuery.of(context).size.width * 0.08, 
            endIndent: MediaQuery.of(context).size.width * 0.08);
        }
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'Carlo Acutis (beato) ver 1.3.1'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.024,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> navegarHacia(int pagina) async {
    switch (pagina) {
      case 0:
        Navigator.of(context).pushNamed(notificacionesConfiguracionPage);
        break;
      case 1:
        Navigator.of(context).pushNamed(temaConfiguracionPage);
        break;
      case 2:
      
        if (await inAppReview.isAvailable()) {
          print('CALIFICAR');
          inAppReview.requestReview();
        }
        break;
      case 3:
        Navigator.of(context).pushNamed(informacionPage);
        break;
      default:
        break;
    }
  }
}