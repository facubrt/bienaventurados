import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/pages/inicio/avioncito_page.dart';
import 'package:flutter/material.dart';
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
    final avioncitoProvider =
        Provider.of<AvioncitoProvider>(context, listen: false);
    avioncitoProvider.configuracionInicial();
  }

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return 
    // Scaffold(
    //   backgroundColor: Colors.transparent,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     leading: Padding(
    //       padding: const EdgeInsets.only(left: 30.0),
    //       child: IconButton(
    //         onPressed: () {
    //           widget.openDrawer();
    //         },
    //         icon: Icon(FlutterIcons.menu_fea,
    //             size: MediaQuery.of(context).size.width * 0.06),
    //       ),
    //     ),
    //   ),
    //   body: 
      avioncitoProvider.avioncitoListo
        ? AvioncitoPage(
          avioncito: avioncitoProvider.avioncito!, 
          openDrawer: widget.openDrawer) 
        : Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            )
          );
  }
}