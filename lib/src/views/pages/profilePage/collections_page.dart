import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/collection_solemnities.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/coming_soon_widget.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatefulWidget {
  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage>
    with TickerProviderStateMixin {
  final tabs = [COLLECTION_SOLEMNITIES, COMING_SOON];

  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(initialIndex: 0, vsync: this, length: tabs.length);
    final prefs = UserPreferences();
    prefs.achievementsSync = false;
    prefs.collectionsSync = false;
    return Scaffold(
      appBar: AppBar(
        //title: Text('Colecciones', style: Theme.of(context).textTheme.headline4),
        elevation: 0.0,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              COLLECTIONS_PAGE_TITLE,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * SCALE_H2,
                  ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: Text(
              COLLECTIONS_PAGE_TEXT,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                  ),
            ),
          ),
          // SOLO PARA VERSION 1.4.4 - SINCRONIZACION CON LA NUBE
          // (!prefs.collectionsSync && prefs.appVersion == '1.4.4')
          //     ? Padding(
          //         padding:
          //             const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(BORDER_RADIUS),
          //             color: Theme.of(context).colorScheme.tertiary,
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(20.0),
          //             child: Column(
          //               children: [
          //                 Text(
          //                   '¡Sincroniza tus colecciones!',
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .subtitle1!
          //                       .copyWith(color: ColorPalette.primaryLight),
          //                 ),
          //                 SizedBox(
          //                   height: MediaQuery.of(context).size.width * 0.04,
          //                 ),
          //                 Text(
          //                   'Ya no más coleccionables perdidos cuando cambies de sesión. ¡Que emoción!',
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodyText1!
          //                       .copyWith(
          //                           fontSize: 16,
          //                           color: ColorPalette.primaryLight),
          //                 ),
          //                 SizedBox(
          //                   height: MediaQuery.of(context).size.width * 0.04,
          //                 ),
          //                 TextButton(
          //                   style: ButtonStyle(
          //                     backgroundColor: MaterialStateProperty.all<Color>(
          //                         ColorPalette.primaryDark.withOpacity(0.2)),
          //                   ),
          //                   child: Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0, vertical: 20.0),
          //                     child: Text(
          //                       'Sincronizar',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .subtitle1!
          //                           .copyWith(
          //                             fontSize:
          //                                 MediaQuery.of(context).size.width *
          //                                     0.03,
          //                             color: ColorPalette.primaryLight,
          //                           ),
          //                     ),
          //                   ),
          //                   onPressed: () async {
          //                     //UPDATE ALL COLLECTION AND ACHIEVEMENT
          //                     final authProvider = Provider.of<AuthProvider>(
          //                         context,
          //                         listen: false);
          //                     final collectionProvider =
          //                         Provider.of<CollectionProvider>(context,
          //                             listen: false);
          //                     collectionProvider.openCollectionsBox();
          //                     final collection = Map<String, bool>();

          //                     Box box = collectionProvider.getCollections();
          //                     box.values.forEach((collectible) {
          //                       if (collectible.desbloqueado) {
          //                         collection.addAll({
          //                           '${collectible.titulo}':
          //                               collectible.desbloqueado
          //                         });
          //                       }
          //                     });
          //                     //ACA SE LLAMA A LA FUNCION QUE SUBE A LA NUBE EL ARRAY
          //                     collectionProvider.updateAllCollectionData(
          //                         authProvider.user.uid!, collection);
          //                     prefs.collectionsSync = true;
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     : SizedBox.shrink(),
          /////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TabBar(
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(100),
              ),
              isScrollable: true,
              controller: tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).primaryColorDark,
              tabs: tabs
                  .map(
                    (collection) => Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          collection.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                CollectionSolemnities(COLLECTION_SOLEMNITIES),
                //ColeccionFiestas('Fiestas'),
                ComingSoonWidget(),
              ],
            ),
          ),
          //
        ]),
      ),
    );
  }
}
