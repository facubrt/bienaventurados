import 'package:bienaventurados/src/models/avioncito_model.dart';
import 'package:bienaventurados/src/views/pages/avioncito/avioncito_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RedescubrePage extends StatefulWidget {
  final Avioncito avioncitoGuardado;

  const RedescubrePage({
    Key? key,
    required this.avioncitoGuardado,
  }) : super(key: key);

  @override
  _RedescubrePageState createState() => _RedescubrePageState();
}

class _RedescubrePageState extends State<RedescubrePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.close_square,
              size: MediaQuery.of(context).size.width * 0.06,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: AvioncitoPage(avioncito: widget.avioncitoGuardado),
    );
  }
}
