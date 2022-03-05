import 'package:bienaventurados/src/data/models/coleccion_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:bienaventurados/src/views/widgets/coleccionable_widget.dart';
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
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
            'Colecciones'.toUpperCase(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.01,
          ),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            height: MediaQuery.of(context).size.width * 0.01,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
                InkWell(
                  onTap: () {
                    showFloatingModalBottomSheet<bool?>(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return coleccionableWidget(context, coleccion);
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                      border: Border.all(width: 2, color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 40),
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
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
