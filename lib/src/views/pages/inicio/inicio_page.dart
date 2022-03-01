import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/drawer_items.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/drawer_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/avioncito_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/colecciones_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/saludo_widget.dart';
import 'package:bienaventurados/src/views/widgets/perfil/comparte_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {

  const InicioPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context);
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    int _imagenPerfil = prefs.imagenPerfil;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('Bienaventurados'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category, size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SaludoWidget(),
                  Spacer(),
                  Padding(
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
                  ),
                ],
              ),
              AvioncitoWidget(),
              coleccionesProvider.coleccionDesbloqueada ? ColeccionesWidget() : SizedBox.shrink(),
              ComparteWidget(),
              //InformacionWidget(),
            ],
          ),
        ),
        // avioncitoProvider.avioncitoListo
        //     ? AvioncitoPage(
        //         avioncito: avioncitoProvider.avioncito!,
        //         openDrawer: widget.openDrawer)
        //     : Center(
        //         child: CircularProgressIndicator(
        //         color: Theme.of(context).primaryColorDark,
        //       )),
      ),
    );
  }
}
