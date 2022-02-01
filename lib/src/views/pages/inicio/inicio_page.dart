import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/avioncito_page.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/avioncito_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/lectura_widget.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/santo_widget.dart';
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

class _InicioPageState extends State<InicioPage>{

  @override
  void initState() {
    super.initState();
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context, listen: false);
    avioncitoProvider.configuracionInicial();
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context, listen: false);
    coleccionesProvider.configuracionInicial();

  }

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return 
    Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Bienaventurados'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.openDrawer();
          },
          icon: Icon(Iconsax.category,
              size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: 
      // SingleChildScrollView(
      //   padding: EdgeInsets.symmetric(horizontal: 20.0),
      //   child: Column(
      //     children: [
      //       SizedBox(height: 40),
      //       SantoWidget(),
      //       SizedBox(height: 40),
      //       LecturaWidget(),
      //       SizedBox(height: 40),
      //       AvioncitoWidget(),
      //     ],
      //   ),
      // ),
      avioncitoProvider.avioncitoListo
        ? AvioncitoPage(
          avioncito: avioncitoProvider.avioncito!, 
          openDrawer: widget.openDrawer) 
        : Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            )
          ),
    );
  }
}