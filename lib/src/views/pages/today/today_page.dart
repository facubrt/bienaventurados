import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/constants.dart';
import 'package:bienaventurados/src/views/pages/today/widgets/avatar_widget.dart';
import 'package:bienaventurados/src/views/pages/today/widgets/paperplane_widget.dart';
import 'package:bienaventurados/src/views/pages/today/widgets/colecciones_widget.dart';
import 'package:bienaventurados/src/views/pages/today/widgets/header_widget.dart';
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
    final collectionProvider = Provider.of<ColeccionesProvider>(context);
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
              //EvangelioWidget(),
              PaperplaneWidget(),
              collectionProvider.coleccionDesbloqueada ? CollectionsWidget() : SizedBox.shrink(),
              //InstruccionesWidget(),
              //InformacionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
