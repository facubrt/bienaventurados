import 'package:bienaventurados/src/models/coleccion_model.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:bienaventurados/src/views/widgets/collectible_widget.dart';
import 'package:bienaventurados/src/views/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CollectionsWidget extends StatelessWidget {
  const CollectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final collectionProvider = Provider.of<CollectionProvider>(context);
    Coleccion? collection = collectionProvider.collectible ?? null;
    final prefs = UserPreferences();
    return prefs.collectionUnlocked
        ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionWidget(title: COLLECTION_SECTION),
                InkWell(
                  onTap: () {
                    showFloatingModalBottomSheet<bool?>(
                      backgroundColor: Theme.of(context).primaryColor,
                      context: context,
                      builder: (context) {
                        return collectibleWidget(context, collection);
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                        border: Border.all(width: 2, color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.note,
                              size: 32,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * SPACE_SECTION,
                            ),
                            Flexible(
                              child: Text(
                                COLLECTIBLE_UNLOCKED_TEXT,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                                    ),
                              ),
                            ),
                          ],
                        ),
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
