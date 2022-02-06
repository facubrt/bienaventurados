import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
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
        title:
            Text('Colecciones', style: Theme.of(context).textTheme.headline4),
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
                  child: Text('Colecciona momentos especiales',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                          )),
                )),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return InkWell(
                      onTap: () {
                        abrirColeccion(context, box, index);
                      },
                      child: box.getAt(index).desbloqueado
                          ? ClipRRect(
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            )
                          : ColorFiltered(
                              colorFilter: greyscaleFilter,
                              child: ClipRRect(
                                child: Image.asset(
                                  box.getAt(index).img,
                                ),
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

  void abrirColeccion(BuildContext context, Box box, int index) {
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
                Container(
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
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      child: ClipRRect(
                        child: Image.asset(
                          box.getAt(index).img,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(box.getAt(index).titulo,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              '${box.getAt(index).dia} de ${MesesData.meses[box.getAt(index).mes - 1].id}, ${DateTime.now().year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
                Text(
                  'Tener un tiempo de tranquilidad, un tiempo para estar solo y escuchar al corazón es tan importante como el mantenerse en movimiento. \n\n¡Paz y Bien!',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
