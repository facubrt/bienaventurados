import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/avioncito_page.dart';
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
  String? _actualConexion;
  String? _ultimaConexion;
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
    _actualConexion = DateTime.now().day.toString();
    _ultimaConexion = prefs.ultimaConexion;
    print('ULTIMA CONEXION $_ultimaConexion');
    if (_ultimaConexion != null) {
      if (_actualConexion == _ultimaConexion) {
        print('MISMO DIA');
        _coleccionDesbloqueada = prefs.coleccionDesbloqueada;
        await avioncitoProvider.mismoAvioncito();
        await coleccionesProvider.getColeccionDesbloqueada();
        await coleccionesProvider.abrirColecciones();
      } else {
        print('NUEVO DIA');
        prefs.ultimaConexion = _actualConexion;
        await avioncitoProvider.nuevoAvioncito();
        coleccionesProvider.abrirColecciones();
        coleccionesProvider.comprobacionColecciones();
      }
    } else {
      print('PRIMERA VEZ');
      prefs.ultimaConexion = _actualConexion;
      await avioncitoProvider.primerInicio();
      coleccionesProvider.crearColecciones();
      coleccionesProvider.comprobacionColecciones();
    }
  }

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SaludoWidget(),
            AvioncitoWidget(),
            ColeccionesWidget(),
            InformacionWidget(),
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
    );
  }
}
