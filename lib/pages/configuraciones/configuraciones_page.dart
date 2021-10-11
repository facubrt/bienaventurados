import 'package:flutter/material.dart';

class ConfiguracionesPage extends StatelessWidget {
  const ConfiguracionesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text(
              'Configuraciones',
              style: Theme.of(context).textTheme.headline2,
            ),
            elevation: 0,
          ),);
  }
}