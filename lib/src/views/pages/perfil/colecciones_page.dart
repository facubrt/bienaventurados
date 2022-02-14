import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ColeccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const ColorFilter greyscaleFilter = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      0.5,
      0,
    ]);

    final coleccionesProvider = Provider.of<ColeccionesProvider>(context);
    Box box = coleccionesProvider.getColeccion();

    return Scaffold(
      appBar: AppBar(
        //title: Text('Colecciones', style: Theme.of(context).textTheme.headline4),
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
                  'Descubre momentos especiales',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                'Colecciona y aprende sobre los momentos claves de nuestra Fe.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return box.getAt(index).desbloqueado
                        ? InkWell(
                            onTap: () {
                              abrirColeccion(context, box.getAt(index));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            ))
                        :
                        // Container(
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context)
                        //           .primaryColorDark
                        //           .withOpacity(0.2),
                        //       borderRadius: BorderRadius.circular(16),
                        //     ),
                        //   );
                        ColorFiltered(
                            colorFilter: greyscaleFilter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            ),
                          );
                  },
                  childCount: box.values.length,
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

  void abrirColeccion(BuildContext context, Coleccion? coleccion) {
    showFloatingModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      builder: (context) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.close_square,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          coleccion!.img,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Flexible(
                      child: Text(
                        coleccion.titulo,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  children: [
                    Text(
                      '${coleccion.dia} de ${MesesData.meses[coleccion.mes - 1].id}, ${DateTime.now().year}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4),
                          ),
                    ),
                    Text(
                      ' - ${coleccion.tipo}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4),
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  coleccion.descripcion,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.036),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Desbloqueado',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
