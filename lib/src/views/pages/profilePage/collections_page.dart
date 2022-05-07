import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/collection_solemnities.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/coming_soon_widget.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatefulWidget {
  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> with TickerProviderStateMixin {
  final tabs = [COLLECTION_SOLEMNITIES, COMING_SOON];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(initialIndex: 0, vsync: this, length: tabs.length);

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
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: Text(
              COLLECTIONS_PAGE_TEXT,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
            ),
          ),
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
