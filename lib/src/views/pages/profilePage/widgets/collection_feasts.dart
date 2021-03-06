import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/views/widgets/collectible_widget.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CollectionFeasts extends StatelessWidget {
  final String scrollKey;
  const CollectionFeasts(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coleccionesProvider = Provider.of<CollectionProvider>(context);
    Box box = coleccionesProvider.getCollections();
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
    List coleccionables = [];
    box.values.where((coleccionable) => coleccionable.tipo == 'Fiesta').forEach(
      (coleccionable) {
        coleccionables.add(coleccionable);
      },
    );
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30),
        key: PageStorageKey(scrollKey),
        itemCount: coleccionables.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => coleccionables[index].tipo == 'Fiesta'
            ? coleccionables[index].desbloqueado
                ? InkWell(
                    onTap: () {
                      showFloatingModalBottomSheet<bool?>(
                          backgroundColor: Theme.of(context).primaryColor,
                          context: context,
                          builder: (context) {
                            return collectibleWidget(context, coleccionables[index]);
                          });
                      //abrirColeccion(context, coleccionables[index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        coleccionables[index].img,
                      ),
                    ))
                : ColorFiltered(
                    colorFilter: greyscaleFilter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        coleccionables[index].img,
                      ),
                    ),
                  )
            : SizedBox.shrink(),
      ),
    );
  }
}
