import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/pages/inicio/avioncito_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


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
                FlutterIcons.x_fea,
                size: MediaQuery.of(context).size.width * 0.06,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: AvioncitoPage(avioncito: widget.avioncitoGuardado));
  }
}
