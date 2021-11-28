import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalConfiguracionesPage extends StatefulWidget {
  const LegalConfiguracionesPage({Key? key}) : super(key: key);

  @override
  _LegalConfiguracionesPageState createState() =>
      _LegalConfiguracionesPageState();
}

class _LegalConfiguracionesPageState extends State<LegalConfiguracionesPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;

  final _listaOpciones = [
    'Políticas de privacidad',
    'Terminos y condiciones',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView.separated(
          itemCount: _listaOpciones.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08,
                  vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                navegarHacia(index);
              },
              title: Text(_listaOpciones[index],
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
                height: 0,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08);
          }),
    );
  }

  Future<void> navegarHacia(int pagina) async {
    switch (pagina) {
      case 0:
        final String url = 'https://bienaventurados.web.app/privacidad';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 1:
        final String url = 'https://bienaventurados.web.app/terminos';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      default:
        break;
    }
  }
}
