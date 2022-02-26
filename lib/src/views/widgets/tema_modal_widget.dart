import 'package:bienaventurados/src/logic/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaModalWidget extends StatefulWidget {
  const TemaModalWidget({Key? key}) : super(key: key);

  @override
  State<TemaModalWidget> createState() => _TemaModalWidgetState();
}

class _TemaModalWidgetState extends State<TemaModalWidget> {
  late SharedPreferences prefs;
  late bool _activarModoNoche;

  @override
  void initState() {
    super.initState();
    obtenerPrefs();
  }

  void obtenerPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _activarModoNoche = prefs.getBool('activarModoNoche') ?? false;
  }

  Future<void> guardarPrefs(String clave, bool nuevoEstado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(clave, nuevoEstado);
  }

  @override
  Widget build(BuildContext context) {
    int _value = 1;

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text('Elige el tema que más te guste',
                    style: Theme.of(context).textTheme.headline6),
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
                    groupValue: _value,
                    value: 2,
                    onChanged: (int? value) {}),
                onTap: () {
                  setState(() {
                    if (_value != 2) {
                      _value = 2;
                      themeProvider.swapTheme();
                      _activarModoNoche = false;
                      guardarPrefs('activarModoNoche', _activarModoNoche);
                    }
                  });

                  Navigator.of(context).pop();
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
                    groupValue: _value,
                    value: 1,
                    onChanged: (int? value) {}),
                onTap: () {
                  setState(() {
                    if (_value != 1) {
                      _value = 1;
                      themeProvider.swapTheme();
                      _activarModoNoche = true;
                      guardarPrefs('activarModoNoche', _activarModoNoche);
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
