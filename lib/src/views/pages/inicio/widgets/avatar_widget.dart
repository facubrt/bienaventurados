import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/drawer_items.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({ Key? key }) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    int _imagenPerfil = prefs.imagenPerfil;
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          drawerProvider.pagina = DrawerItems.perfil;
          Navigator.of(context).pushReplacementNamed(dashboardPage);
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.12,
          width: MediaQuery.of(context).size.width * 0.12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/perfil/perfil-0${_imagenPerfil + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}