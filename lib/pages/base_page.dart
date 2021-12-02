import 'package:bienaventurados/pages/construir/construir_pagina.dart';
import 'package:bienaventurados/pages/inicio/inicio_page.dart';
import 'package:bienaventurados/pages/inicio/inicio_pagina.dart';
import 'package:bienaventurados/pages/perfil/guardados_page.dart';
import 'package:bienaventurados/pages/perfil/guardados_pagina.dart';
import 'package:bienaventurados/pages/perfil/perfil_pagina.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BasePage extends StatefulWidget {
  const BasePage({ Key? key }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  int currentIndex = 0;

  List pages = [
    InicioPagina(),
    GuardadosPagina(),
    ConstruirPagina(),
    PerfilPagina(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 12,
        onTap: onTap,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorDark.withOpacity(0.2),
        elevation: 0,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            label: 'Hoy',
            icon: Icon(FlutterIcons.compass_fea),
          ),
          BottomNavigationBarItem(
            label: 'Guardados',
            icon: Icon(FlutterIcons.bookmark_fea),
          ),
          BottomNavigationBarItem(
            label: 'Construir',
            icon: Icon(FlutterIcons.plus_circle_fea),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(FlutterIcons.user_fea),
          ),
        ],
      ),
    );
  }
}