import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:bienaventurados/widgets/floating_modal.dart';
import 'package:bienaventurados/widgets/perfil/comparte_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class PerfilPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const PerfilPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final snackbar = SnackBar(
    //   backgroundColor: Theme.of(context).colorScheme.secondary,
    //   content: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Text(
    //         '¡Oh, oh! Parece que todavía no puedes acceder a esta parte. ¡Regresa pronto!',
    //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
    //               color: Theme.of(context).primaryColor,
    //             )),
    //   ),
    // );

    final authProvider = Provider.of<AuthProvider>(context);
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    final prefs = PreferenciasUsuario();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: () {
              openDrawer();
            },
            icon: Icon(FlutterIcons.menu_fea, size: 22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hola, ${authProvider.usuario.nombre ?? ''}',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ).padding(horizontal: 40, vertical: 40),
            ComparteWidget().padding(all: 20),

            // InkWell(
            //   onTap: () {
            //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
            //   },
            //   child: Text(
            //     'Logros',
            //     style: Theme.of(context).textTheme.headline1,
            //   ),
            // ).padding(horizontal: 40),
            // SizedBox(height: 40),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                //ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.of(context)
                    .pushNamed(guardadosPage, arguments: openDrawer);
              },
              child: Text(
                'Guardados',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
              ),
            ).padding(horizontal: 40),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(construirPage);
              },
              child: Text(
                'Construir',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
              ),
            ).padding(horizontal: 40),
            (authProvider.usuario.clase == 'administrador')
                ? Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(tallerPage);
                        },
                        child: Text(
                          'Taller',
                          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
                        ),
                      ).padding(horizontal: 40),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(height: MediaQuery.of(context).size.width * 0.16),
            InkWell(
              onTap: () {
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
                            Text('Todo camino merece un descanso',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontSize: MediaQuery.of(context).size.width * 0.04
                                )),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                            Text(
                              'Tener un tiempo de tranquilidad, un tiempo para estar solo y escuchar al corazón es tan importante como el mantenerse en movimiento. \n\n¿Deseas descansar de esta aventura?',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width * 0.08,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'Cancelar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            fontSize: MediaQuery.of(context).size.width * 0.04,
                                            color: Theme.of(context)
                                                  .primaryColorDark),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    avioncitoProvider.eliminarDB();
                                    authProvider.signOut();
                                    SharedPrefs.limpiarPrefs();
                                    prefs.modoNoche = false;
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            bienaventuradosPage, (route) => false);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'Salir',
                                      style:
                                          Theme.of(context).textTheme.subtitle1!.copyWith(
                                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
              },
              child: Text(
                'Salir',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  color: Theme.of(context).colorScheme.secondary
                ),
              ),
            ).padding(horizontal: 40),
            SizedBox(height: MediaQuery.of(context).size.width * 0.06),
          ],
        ),
      ),
    );
  }
}
