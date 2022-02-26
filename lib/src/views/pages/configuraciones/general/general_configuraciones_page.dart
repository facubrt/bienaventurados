import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

enum Availability { loading, available, unavailable }

class GeneralConfiguracionesPage extends StatefulWidget {
  const GeneralConfiguracionesPage({Key? key}) : super(key: key);

  @override
  _GeneralConfiguracionesPageState createState() =>
      _GeneralConfiguracionesPageState();
}

class _GeneralConfiguracionesPageState
    extends State<GeneralConfiguracionesPage> {
  late SharedPreferences prefs;
  final InAppReview _inAppReview = InAppReview.instance;
  Availability _availability = Availability.loading;
  String _appStoreId = '';
  String _microsoftStoreId = '';

  final _listaOpciones = [
    'Notificaciones',
    'Cambiar tema',
    'Calificanos',
    //'Reporta un error',
    'Acerca de',
  ];

  // void _setAppStoreId(String id) => _appStoreId = id;

  // void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  // Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (e) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('General'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
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
                color: Theme.of(context).primaryColorDark,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08);
          }),
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
        final logroProvider =
            Provider.of<LogroProvider>(context, listen: false);
        logroProvider.comprobacionLogros('calificar-app');

        // if (await _inAppReview.isAvailable()) {
        //   print('CALIFICAR');
        //   _inAppReview.requestReview();
        // }
        if (await _inAppReview.isAvailable()) {
          _openStoreListing();
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
