import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:bienaventurados/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuentaConfiguracionesPage extends StatefulWidget {
  const CuentaConfiguracionesPage({ Key? key }) : super(key: key);

  @override
  _CuentaConfiguracionesPageState createState() => _CuentaConfiguracionesPageState();
}

class _CuentaConfiguracionesPageState extends State<CuentaConfiguracionesPage> {
  
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;
  
  final _listaOpciones = [
    'Actualizar Nombre',
    //'Actualizar Correo',
    // 'Actualizar Contraseña'
    //'Eliminar cuenta',
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
            indent: MediaQuery.of(context).size.width * 0.08, 
            endIndent: MediaQuery.of(context).size.width * 0.08);
        }
      ),
    );
  }

  Future<void> navegarHacia(int pagina) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    switch (pagina) {
      case 0:
        Navigator.of(context).pushNamed(actualizarNombrePage);
        break;
      // case 1:
      //   Navigator.of(context).pushNamed(actualizarCorreoPage);
      //   break;
      case 1:
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
                      'En Bienaventurados estamos muy agradecidos por haber compartido este camino juntos.\n\n¡Paz y Bien!',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Cancelar',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color:
                                          Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            avioncitoProvider.eliminarDB();
                            authProvider.signOut();
                            prefs.limpiarPrefs();
                            prefs.modoNoche = false;
                            authProvider.deleteUser();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                bienaventuradosPage, (route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Eliminar cuenta',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                            ),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     avioncitoProvider.eliminarDB();
                        //     SharedPrefs.limpiarPrefs();
                        //     authProvider.signOut();
                        //     Navigator.of(context)
                        //         .pushNamedAndRemoveUntil(
                        //             comenzarPage, (route) => false);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 10),
                        //     child: Text(
                        //       'Eliminar cuenta',
                        //       style:
                        //           Theme.of(context).textTheme.subtitle1,
                        //     ),
                        //   ),
                        // ),
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