import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/avioncito_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/colecciones_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/informacion_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/saludo_widget.dart';
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
  final prefs = PreferenciasUsuario();
  int? _actualConexion;
  int? _ultimaConexion;
  String? _versionApp;
  bool _coleccionDesbloqueada = false;

  @override
  void initState() {
    super.initState();
    comprobacionDia();
    // final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    // avioncitoProvider.configuracionInicial();
    // final coleccionesProvider = Provider.of<ColeccionesProvider>(context, listen: false);
    // coleccionesProvider.configuracionInicial();
  }

  void comprobacionDia() async {
    final avioncitoProvider =
        Provider.of<AvioncitoProvider>(context, listen: false);
    final coleccionesProvider =
        Provider.of<ColeccionesProvider>(context, listen: false);
    final logroProvider = Provider.of<LogroProvider>(context, listen: false);
    _actualConexion = DateTime.now().day.toInt();
    _ultimaConexion = prefs.ultimaConexion;
    _versionApp = prefs.versionApp;
    print(_versionApp);
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('MISMO DIA');
        _coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await avioncitoProvider.mismoAvioncito();
        await coleccionesProvider.getColeccionDesbloqueada();
        logroProvider.abrirLogros();
        await coleccionesProvider.abrirColecciones();
      } else {
        print('NUEVO DIA');
        final ultimoDia = DateTime(
            DateTime.now().year, DateTime.now().month, _ultimaConexion!);
        final nuevoDia = DateTime(
            DateTime.now().year, DateTime.now().month, _actualConexion!);
        if (ultimoDia.month == nuevoDia.month ||
            ultimoDia.month + 1 == nuevoDia.month) {
          if (ultimoDia.day + 1 == nuevoDia.day || 1 == nuevoDia.day) {
            print('CONSTANCIA AUMENTADA');
            logroProvider.comprobacionLogros('constancia');
          } else {
            print('CONSTANCIA RESTABLECIDA');
            logroProvider.restablecerConstancia();
          }
        }
        prefs.ultimaConexion = _actualConexion;
        await avioncitoProvider.nuevoAvioncito();
        coleccionesProvider.abrirColecciones();
        logroProvider.abrirLogros();
        coleccionesProvider.comprobacionColecciones();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _actualConexion;
      await avioncitoProvider.primerInicio();
      coleccionesProvider.crearColecciones();
      logroProvider.iniciarLogros();
      coleccionesProvider.comprobacionColecciones();
      logroProvider.comprobacionLogros('Primer Inicio');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Iconsax.category,
              size: MediaQuery.of(context).size.width * 0.06),
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
              ColeccionesWidget(),
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
