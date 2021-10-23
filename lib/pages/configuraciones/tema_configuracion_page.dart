import 'package:bienaventurados/providers/theme_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class TemaConfiguracionPage extends StatefulWidget {

  const TemaConfiguracionPage({Key? key,})
      : super(key: key);

  @override
  _TemaConfiguracionPageState createState() => _TemaConfiguracionPageState();
}

class _TemaConfiguracionPageState extends State<TemaConfiguracionPage> {
  // late bool _activarModoNoche;
  late int _opcion;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    if (prefs.modoNoche) {
      _opcion = 1;
    } else {
      _opcion = 2;
    }
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text('Elige el tema que más te guste',
                style: Theme.of(context).textTheme.headline1),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
            dense: true,
            isThreeLine: true,
            leading: Icon(FlutterIcons.sun_fea,
                size: 22, color: Theme.of(context).primaryColorDark),
            title: Text(
              'Claro',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              'Ilumina otros corazones con tu luz.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _opcion,
                value: 2,
                onChanged: (int? value) {}),
            onTap: () {
              setState(() {
                if (_opcion != 2) {
                  _opcion = 2;
                  themeProvider.swapTheme();
                  // _activarModoNoche = false;
                  prefs.modoNoche = false;
                }
              });
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
            dense: true,
            isThreeLine: true,
            leading: Icon(FlutterIcons.moon_fea,
                size: 22, color: Theme.of(context).primaryColorDark),
            title: Text(
              'Oscuro',
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              'Aventurate en el silencio de la noche.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _opcion,
                value: 1,
                onChanged: (int? value) {}),
            onTap: () {
              setState(() {
                if (_opcion != 1) {
                  _opcion = 1;
                  themeProvider.swapTheme();
                  // _activarModoNoche = true;
                  prefs.modoNoche = true;
                }
              });
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
