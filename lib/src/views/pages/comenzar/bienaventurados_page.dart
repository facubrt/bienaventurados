import 'package:bienaventurados/src/data/datasources/local/drawer_items.dart';
import 'package:bienaventurados/src/data/models/drawer_item_model.dart';
import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/logic/providers/theme_provider.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/views/pages/comenzar/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../logic/providers/providers.dart';

class BienaventuradosPage extends StatefulWidget {
  const BienaventuradosPage({Key? key}) : super(key: key);

  @override
  State<BienaventuradosPage> createState() => _BienaventuradosPageState();
}

class _BienaventuradosPageState extends State<BienaventuradosPage> {
  // Boton de carga
  int _state = 0;

  @override
  void initState() {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false,);
    themeProvider.activarModoNoche(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        child: HeaderWidget(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    if (_state == 0) {
                        _state = 1;
                      authProvider.googleSignIn().then((result) {
                        if (result != null) {
                          prefs.sesionIniciada = true;
                          drawerProvider.pagina = DrawerItems.inicio;
                          Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
                        }
                      });
                    }
                  });
                },
                child: setUpButtonChild(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  drawerProvider.pagina = DrawerItems.inicio;
                  Navigator.of(context).pushNamed(iniciarAventuraPage);
                },
                child: Text('Continuar con Correo',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        'Continuar con Google', style: Theme.of(context).textTheme.headline4!.copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: Theme.of(context).primaryColorDark
        )
      );
    } else if (_state == 1) {
      return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
            )
          );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}