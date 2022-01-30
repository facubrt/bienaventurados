import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/views/widgets/perfil/comparte_widget.dart';
import 'package:bienaventurados/src/views/widgets/perfil/perfil_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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
          icon: Icon(Iconsax.category, size: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            //   child: Text(
            //     'Hola, ${authProvider.usuario.nombre ?? ''}',
            //     style: Theme.of(context).textTheme.headline1!.copyWith(
            //           fontSize: MediaQuery.of(context).size.width * 0.08,
            //         ),
            //   ),
            // ),
            PerfilWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ComparteWidget(),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08,
                  vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                Navigator.of(context).pushNamed(logrosPage);
              },
              title: Text('Logros',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
            ),
            Divider(
              height: 0,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08,
              color: Theme.of(context).primaryColorDark,
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08,
                  vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                Navigator.of(context).pushNamed(coleccionesPage);
              },
              title: Text('Colecciones',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
            ),
            Divider(
              height: 0,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08,
              color: Theme.of(context).primaryColorDark,
            ),
            (authProvider.usuario.clase == 'administrador')
                ? ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                        vertical: MediaQuery.of(context).size.width * 0.04),
                    onTap: () {
                      Navigator.of(context).pushNamed(tallerPage);
                    },
                    title: Text('Taller',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                            ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: MediaQuery.of(context).size.width * 0.08),
          ],
        ),
      ),
    );
  }
}
