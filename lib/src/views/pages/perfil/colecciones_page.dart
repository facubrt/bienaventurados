import 'package:bienaventurados/src/views/pages/perfil/widgets/coleccion_solemnidades.dart';
import 'package:bienaventurados/src/views/pages/perfil/widgets/proximamente_widget.dart';
import 'package:flutter/material.dart';

class ColeccionesPage extends StatefulWidget {
  @override
  State<ColeccionesPage> createState() => _ColeccionesPageState();
}

class _ColeccionesPageState extends State<ColeccionesPage> with TickerProviderStateMixin {
  final tabs = ['Solemnidades', 'Muy pronto...'];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(initialIndex: 0, vsync: this, length: tabs.length);

    return Scaffold(
      appBar: AppBar(
        //title: Text('Colecciones', style: Theme.of(context).textTheme.headline4),
        elevation: 0.0,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Descubre momentos especiales',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: Text(
              'Colecciona y aprende sobre los momentos claves de nuestra Fe.',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TabBar(
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(100),
              ),
              isScrollable: true,
              controller: tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).primaryColorDark,
              tabs: tabs
                  .map(
                    (coleccion) => Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          coleccion.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ColeccionSolemnidades('Solemnidades'),
                //ColeccionFiestas('Fiestas'),
                ProximamenteWidget(),
              ],
            ),
          ),
          // 
        ]),
      ),
    );
  }
}
