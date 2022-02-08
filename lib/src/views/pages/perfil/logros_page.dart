import 'package:bienaventurados/src/data/datasources/local/logros_data.dart';
import 'package:bienaventurados/src/data/models/logro_model.dart';
import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LogrosPage extends StatelessWidget {
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
    final logroProvider = Provider.of<LogroProvider>(context, listen: false);
    Box box = logroProvider.getLogros();

    return Scaffold(
      appBar: AppBar(
        title: Text('Logros', style: Theme.of(context).textTheme.headline4),
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
                  child: Text('Obtené todos los logros',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                          )),
                )),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return box.getAt(index).desbloqueado
                        ? InkWell(
                            onTap: () {
                              abrirLogro(context, box.getAt(index));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            ))
                        : ColorFiltered(
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

  void abrirLogro(BuildContext context, Logro? logro) {
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          logro!.img,
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
                            Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Iconsax.close_square,
                                  size:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Text(logro.titulo,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Tener un tiempo de tranquilidad, un tiempo para estar solo y escuchar al corazón es tan importante como el mantenerse en movimiento. \n\n¡Paz y Bien!',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Desbloqueado',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
