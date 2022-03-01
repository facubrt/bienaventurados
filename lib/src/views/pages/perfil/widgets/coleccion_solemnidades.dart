import 'package:bienaventurados/src/logic/providers/colecciones_provider.dart';
import 'package:bienaventurados/src/views/widgets/coleccionable_widget.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ColeccionSolemnidades extends StatelessWidget {
  final String scrollKey;
  const ColeccionSolemnidades(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coleccionesProvider = Provider.of<ColeccionesProvider>(context);
    Box box = coleccionesProvider.getColeccion();
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

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GridView.builder(
        key: PageStorageKey(scrollKey),
        itemCount: box.values.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => box.getAt(index).desbloqueado
            ? InkWell(
                onTap: () {
                  showFloatingModalBottomSheet<bool?>(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return coleccionableWidget(context, box.getAt(index));
                      });
                  //abrirColeccion(context, box.getAt(index));
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
              ),
      ),
    );
  }
}
