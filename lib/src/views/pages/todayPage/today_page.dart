import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/views/pages/todayPage/widgets/avatar_widget.dart';
import 'package:bienaventurados/src/views/pages/todayPage/widgets/paperplane_widget.dart';
import 'package:bienaventurados/src/views/pages/todayPage/widgets/collections_widget.dart';
import 'package:bienaventurados/src/views/pages/todayPage/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({
    Key? key,
  }) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {

  @override
  Widget build(BuildContext context) {
    final collectionProvider = Provider.of<CollectionProvider>(context);
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('Hoy'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category, size: MediaQuery.of(context).size.width * DIMENSION_ICON),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HeaderWidget(),
                  Spacer(),
                  AvatarWidget(),
                ],
              ),
              
              //GospelWidget(),
              collectionProvider.collectibleUnlocked ? CollectionsWidget() : SizedBox.shrink(),
              PaperplaneWidget(),
              //InstructionsWidget(),
              //InformacionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
