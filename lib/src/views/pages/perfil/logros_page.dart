import 'package:bienaventurados/src/data/datasources/local/logros_data.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LogrosPage extends StatelessWidget {
  
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
                  child: Text(
                    'Obtené todos los logros',
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
                        abrirLogro(context, index);
                      },
                      child: Logros.logros[index].desbloqueado 
                        ? ClipRRect(
                            child: Image.asset(
                              Logros.logros[index].img,
                            ),    
                          )
                        : ColorFiltered(
                          colorFilter: greyscaleFilter,
                          child: ClipRRect(
                            child: Image.asset(
                              Logros.logros[index].img,
                            ),    
                          ),
                        ),
                    );
                  },
                  childCount: Logros.logros.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    void abrirLogro(BuildContext context, int index) {
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
                          Logros.logros[index].img,
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
                            Text(Logros.logros[index].titulo,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05)),
                            
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