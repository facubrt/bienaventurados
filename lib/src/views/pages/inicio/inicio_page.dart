import 'package:bienaventurados/src/data/datasources/local/local_db.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/info_provider.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/avioncito_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/colecciones_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/informacion_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/saludo_widget.dart';
import 'package:bienaventurados/src/views/widgets/perfil/comparte_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {
  final VoidCallback openDrawer;

  const InicioPage({
    Key? key,
    required this.openDrawer,
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('Bienaventurados'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.openDrawer();
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
              SaludoWidget(),
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
