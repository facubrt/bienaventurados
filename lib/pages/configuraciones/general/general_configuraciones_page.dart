import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralConfiguracionesPage extends StatefulWidget {
  const GeneralConfiguracionesPage({ Key? key }) : super(key: key);

  @override
  _GeneralConfiguracionesPageState createState() => _GeneralConfiguracionesPageState();
}

class _GeneralConfiguracionesPageState extends State<GeneralConfiguracionesPage> {
  
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
            color: Theme.of(context).primaryColorDark,
            indent: MediaQuery.of(context).size.width * 0.08, 
            endIndent: MediaQuery.of(context).size.width * 0.08);
        }
      ),
    );
  }

    Future<void> navegarHacia(int pagina) async {
    switch (_listaOpciones[pagina]) {
      case 'Notificaciones':
        Navigator.of(context).pushNamed(notificacionesConfiguracionPage);
        break;
      case 'Cambiar tema':
        Navigator.of(context).pushNamed(temaConfiguracionPage);
        break;
      case 'Calificanos':
      
        if (await inAppReview.isAvailable()) {
          print('CALIFICAR');
          inAppReview.requestReview();
        }
        break;
      case 'Acerca de':
        Navigator.of(context).pushNamed(informacionPage);
        break;
      default:
        break;
    }
  }
}