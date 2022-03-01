import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/logic/providers/compartir_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

Widget coleccionableWidget(BuildContext context, Coleccion? coleccion) {
  final coleccionesProvider = Provider.of<ColeccionesProvider>(context);
  ScreenshotController screenshotController = ScreenshotController();
  final compartirProvider =
      Provider.of<CompartirProvider>(context, listen: false);
  return Screenshot(
    controller: screenshotController,
    child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(16)),
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20.0),
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  coleccion!.desbloqueado
                  ? IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.export_1,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () {
                      compartirProvider.compartirColeccionable(
                          screenshotController, coleccion.titulo);
                    },
                  )
                  : SizedBox.shrink(),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.close_square,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
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
                      coleccion.img,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  '${coleccion.dia} de ${MesesData.meses[coleccion.mes - 1].id}, ${DateTime.now().year}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                ),
                Text(
                  ' - ${coleccion.tipo}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
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
          coleccion.desbloqueado
              ? Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Desbloqueado',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                )
              : InkWell(
                onTap: () {
                  coleccionesProvider.setColeccionDesbloqueada = false;
                        coleccionesProvider.setColeccion(coleccion, true);
                        Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    color: Colores.acentoSecundario,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Desbloquear',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: MediaQuery.of(context).size.width * 0.03,
                                color: Theme.of(context).primaryColor)),
                    ),
                    ),
              ),
        ],
      ),
    ),
  );
}
