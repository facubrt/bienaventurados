import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ColeccionesWidget extends StatelessWidget {
  const ColeccionesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context);
    Coleccion? coleccion = coleccionesProvider.coleccion ?? null;
    //avioncitoProvider.getTiempoLiturgico();
    final prefs = PreferenciasUsuario();
    return prefs.coleccionDesbloqueada
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: InkWell(
              onTap: () {
                abrirColeccion(context, coleccion);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.note,
                        size: 32,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Flexible(
                        child: Text(
                          '¡Bienaventurado seas! Has desbloqueado un nuevo Coleccionable',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.032,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }

  void abrirColeccion(BuildContext context, Coleccion? coleccion) {
    final coleccionesProvider =
        Provider.of<ColeccionesProvider>(context, listen: false);
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
                          coleccion!.img,
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
                            Text(coleccion.titulo,
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
                              '${coleccion.dia} de ${MesesData.meses[coleccion.mes - 1].id}, ${DateTime.now().year}',
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
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      coleccionesProvider.setColeccionDesbloqueada = false;
                      coleccionesProvider.setColeccion(coleccion, true);
                      Navigator.of(context).pop();
                    },
                    child: Text('Desbloquear',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
