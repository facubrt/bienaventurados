import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:bienaventurados/src/views/widgets/collectible_widget.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CollectionSolemnities extends StatelessWidget {
  final String scrollKey;
  const CollectionSolemnities(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final collectionProvider = Provider.of<CollectionProvider>(context);
    Box box = collectionProvider.getCollections();
    ColorFilter greyscaleFilter = getGreyScaleFilter();

    List collection = [];
    box.values.where((collectible) => collectible.tipo == 'Solemnidad').forEach(
      (collectible) {
        collection.add(collectible);
      },
    );
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30),
        key: PageStorageKey(scrollKey),
        itemCount: collection.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => collection[index].desbloqueado
            ? InkWell(
                onTap: () {
                  showFloatingModalBottomSheet<bool?>(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return collectibleWidget(context, collection[index]);
                      });
                  //abrirColeccion(context, coleccionables[index]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    collection[index].img,
                  ),
                ))
            : ColorFiltered(
                colorFilter: greyscaleFilter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    collection[index].img,
                  ),
                ),
              ),
      ),
    );
  }
}
