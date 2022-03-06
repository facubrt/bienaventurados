import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuentaConfiguracionesPage extends StatefulWidget {
  const CuentaConfiguracionesPage({Key? key}) : super(key: key);

  @override
  _CuentaConfiguracionesPageState createState() =>
      _CuentaConfiguracionesPageState();
}

class _CuentaConfiguracionesPageState extends State<CuentaConfiguracionesPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;

  final _listaOpciones = [
    'Actualizar Nombre',
    'Actualizar Correo',
    // 'Actualizar Contraseña',
    'Eliminar Cuenta',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Cuenta'),
        leading: InkWell(
          onTap: () {Navigator.of(context).pop();},
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    final prefs = UserPreferences();
    switch (_listaOpciones[pagina]) {
      case 'Actualizar Nombre':
        Navigator.of(context).pushNamed(actualizarNombrePage);
        break;
      case 'Actualizar Correo':
        Navigator.of(context).pushNamed(actualizarCorreoPage);
        break;
      case 'Actualizar Contraseña':
        Navigator.of(context).pushNamed(actualizarContrasenaPage);
        break;
      case 'Eliminar Cuenta':
        showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('¿Es este el final de nuestra aventura?',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.04)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Text(
                      'En Bienaventurados estamos muy agradecidos por haber compartido este camino juntos.\n\n¡Hasta Pronto!',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color:
                                          Theme.of(context).primaryColorDark)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            avioncitoProvider.eliminarDB();
                            prefs.cleanPrefs();
                            prefs.modoNoche = false;
                            authProvider.deleteUser();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              bienaventuradosPage, (route) => false
                            );
                          },
                          child: Text('Eliminar',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }
}
