import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const PerfilPage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 4.0),
          child: InkWell(
            onTap: () {
              openDrawer();
            },
            child: Icon(FlutterIcons.menu_fea, size: 24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              (authProvider.usuario.clase == 'administrador')
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(tallerPage);
                      },
                      child: Text(
                        'Taller',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 40),
              (authProvider.usuario.clase == 'editor' ||
                      authProvider.usuario.clase == 'administrador')
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(construirPage);
                      },
                      child: Text(
                        'Construir',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
