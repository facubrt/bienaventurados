import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({
    Key? key,
  }) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  late int _option;

  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    if (prefs.darkMode) {
      _option = 1;
    } else {
      _option = 2;
    }
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );

    final logroProvider = Provider.of<AchievementProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Text('Tema'),
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
            child: Text(THEME_PAGE_TITLE,
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
              THEME_DAY_TITLE,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                THEME_DAY_TEXT,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _option,
                value: 2,
                onChanged: (int? value) {}),
            onTap: () {
              setState(() {
                if (_option != 2) {
                  _option = 2;
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
              THEME_NIGHT_TITLE,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                THEME_NIGHT_TEXT,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
              ),
            ),
            trailing: Radio(
                activeColor: Theme.of(context).colorScheme.secondary,
                groupValue: _option,
                value: 1,
                onChanged: (int? value) {}),
            onTap: () {
              logroProvider.achievementsCheck(ACHIEVEMENT_NIGHT_MODE);
              setState(() {
                if (_option != 1) {
                  _option = 1;
                  themeProvider.swapTheme();
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
