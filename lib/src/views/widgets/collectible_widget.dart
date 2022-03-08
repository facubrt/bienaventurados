import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/data/local/meses_data.dart';
import 'package:bienaventurados/src/models/coleccion_model.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

Widget collectibleWidget(BuildContext context, Coleccion? collection) {
  final collectionProvider = Provider.of<CollectionProvider>(context);
  ScreenshotController screenshotController = ScreenshotController();
  final shareProvider = Provider.of<ShareProvider>(context, listen: false);
  return Screenshot(
    controller: screenshotController,
    child: Container(
      color: Theme.of(context).primaryColor,
      child: Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(BORDER_RADIUS)),
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
                  collection!.desbloqueado
                  ? IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.export_1,
                      size: MediaQuery.of(context).size.width * DIMENSION_ICON,
                    ),
                    onPressed: () {
                      shareProvider.shareCollectible(
                          screenshotController, collection.titulo);
                    },
                  )
                  : SizedBox.shrink(),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.close_square,
                      size: MediaQuery.of(context).size.width * DIMENSION_ICON,
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
                    borderRadius: BorderRadius.circular(BORDER_RADIUS),
                    child: Image.asset(
                      collection.img,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * SPACE_SECTION,
                ),
                Flexible(
                  child: Text(
                    collection.titulo,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_H3),
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
                  '${collection.dia} de ${MesesData.meses[collection.mes - 1].id}, ${DateTime.now().year}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                ),
                Text(
                  ' - ${collection.tipo}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
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
              collection.descripcion,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * SCALE_BODY),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * SPACE_SECTION,
          ),
          collection.desbloqueado
              ? Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      COLLECTIBLE_UNLOCKED_BTN,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * SCALE_BODY,
                              color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                )
              : InkWell(
                onTap: () {
                  collectionProvider.setCollectibleUnlocked = false;
                        collectionProvider.setCollectible(collection, true);
                        Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    color: ColorPalette.accentSecondary,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(COLLECTIBLE_LOCKED_BTN,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                                color: Theme.of(context).primaryColor)),
                    ),
                    ),
              ),
        ],
      ),
      ),
    ),
    );
}
