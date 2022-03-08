import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TemaConfiguracionPage extends StatefulWidget {
  const TemaConfiguracionPage({
    Key? key,
  }) : super(key: key);

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
    final prefs = UserPreferences();
    if (prefs.darkMode) {
      _opcion = 1;
    } else {
      _opcion = 2;
    }
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );

    final logroProvider = Provider.of<AchievementProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Tema'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text('Elige el tema que más te guste',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    )),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            dense: true,
            leading: Icon(Iconsax.sun_1,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).primaryColorDark),
            title: Text(
              'Claro',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Selecciona esta opción para iluminar a otros corazones con tu luz.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
              ),
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
                  prefs.darkMode = false;
                }
              });
            },
          ),
          Divider(
              height: 0,
              color: Theme.of(context).primaryColorDark,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            dense: true,
            leading: Icon(Iconsax.moon,
                size: MediaQuery.of(context).size.width * 0.06,
                color: Theme.of(context).primaryColorDark),
            title: Text(
              'Oscuro',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Selecciona esta opción para aventurarte en el silencio de la noche.',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _opcion,
                value: 1,
                onChanged: (int? value) {}),
            onTap: () {
              logroProvider.achievementsCheck('modo-noche');
              setState(() {
                if (_opcion != 1) {
                  _opcion = 1;
                  themeProvider.swapTheme();
                  // _activarModoNoche = true;
                  prefs.darkMode = true;
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
