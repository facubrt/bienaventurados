import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/views/pages/perfil/widgets/estadisticas_widget.dart';
import 'package:bienaventurados/src/views/pages/perfil/widgets/perfil_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const PerfilPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            widget.openDrawer();
          },
          icon: Icon(Iconsax.category, size: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PerfilWidget(),
            EstadisticasWidget(),
            //MochilaWidget(),
            
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
                    title: Text(
                      'Taller',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
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
