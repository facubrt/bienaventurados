import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/views/pages/inicio/avioncito_page.dart';
import 'package:flutter/material.dart';


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
    return AvioncitoPage(avioncito: widget.avioncitoGuardado);
  }
}
