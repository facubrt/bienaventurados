import 'package:bienaventurados/src/data/datasources/local/colecciones_data.dart';
import 'package:bienaventurados/src/data/datasources/local/logros_data.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ColeccionesPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    
    const ColorFilter greyscaleFilter = ColorFilter.matrix(
      <double>[
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0,0,0,0.5,0,
        ]
      );

    return Scaffold(
      appBar: AppBar(
        title: Text('Colecciones', style: Theme.of(context).textTheme.headline4),
        elevation: 0.0,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) { 
          overScroll.disallowGlow();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
                padding: const EdgeInsets.all(40.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Colecciona momentos especiales',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    )),)
              ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return InkWell(
                      onTap: () {
                        abrirColeccion(context, index);
                      },
                      child: Colecciones.colecciones[index].desbloqueado 
                        ? ClipRRect(
                            child: Image.asset(
                              Colecciones.colecciones[index].img,
                            ),    
                          )
                        : ColorFiltered(
                          colorFilter: greyscaleFilter,
                          child: ClipRRect(
                            child: Image.asset(
                              Colecciones.colecciones[index].img,
                            ),    
                          ),
                        ),
                    );
                  },
                  childCount: Colecciones.colecciones.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void abrirColeccion(BuildContext context, int index) {
    showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Colecciones.colecciones[index].titulo,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.05)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          child: ClipRRect(
                                  child: Image.asset(
                                    Colecciones.colecciones[index].img,
                                  ),    
                                ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.height * 0.04,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Colecciones.colecciones[index].fecha,
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                              SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                              Text(
                                'Tener un tiempo de tranquilidad, un tiempo para estar solo y escuchar al corazón es tan importante como el mantenerse en movimiento. \n\n¡Paz y Bien!',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: MediaQuery.of(context).size.width * 0.04),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 10),
                        //     child: Text(
                        //       'Cancelar',
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .subtitle1!
                        //           .copyWith(
                        //               fontSize:
                        //                   MediaQuery.of(context).size.width *
                        //                       0.04,
                        //               color:
                        //                   Theme.of(context).primaryColorDark),
                        //     ),
                        //   ),
                        // ),
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Desbloquear',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color:
                                          Theme.of(context).primaryColorDark)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}