import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:bienaventurados/widgets/floating_modal.dart';
import 'package:bienaventurados/widgets/perfil/comparte_widget.dart';
import 'package:bienaventurados/widgets/perfil/logros_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class PerfilPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const PerfilPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            '¡Oh, oh! Parece que todavía no puedes acceder a este lugar. ¡Regresa pronto!',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            openDrawer();
          },
          icon: Icon(FlutterIcons.menu_fea, size: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Text(
                'Hola, ${authProvider.usuario.nombre ?? ''}',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ComparteWidget(),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: Text(
                  'Logros',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                child: Text(
                  'Colecciones',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     //ScaffoldMessenger.of(context).showSnackBar(snackbar);
            //     Navigator.of(context)
            //         .pushNamed(guardadosPage, arguments: openDrawer);
            //   },
            //   child: Text(
            //     'Guardados',
            //     style: Theme.of(context).textTheme.headline1!.copyWith(
            //     fontSize: MediaQuery.of(context).size.width * 0.08,
            //   ),
            //   ),
            // ).padding(horizontal: 40),
            // SizedBox(height: 40),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(construirPage);
            //   },
            //   child: Text(
            //     'Construir',
            //     style: Theme.of(context).textTheme.headline1!.copyWith(
            //     fontSize: MediaQuery.of(context).size.width * 0.08,
            //   ),
            //   ),
            // ).padding(horizontal: 40),
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
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                              ),
                        ),
                      ).padding(horizontal: 40),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(height: MediaQuery.of(context).size.width * 0.08),
          ],
        ),
      ),
    );
  }
}
