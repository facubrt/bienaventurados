import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/stats_widget.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/profile_widget.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/share_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.restartConstancy) {
      authProvider.restoreConstancy();
      authProvider.restartConstancy = false;
    } else if (authProvider.increaseConstancy) {
      authProvider.updateConstancy();
      authProvider.increaseConstancy = false;
    }

    return Scaffold(
      backgroundColor: drawerProvider.isDrawerOpen
          ? Colors.transparent
          : Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category,
              size: MediaQuery.of(context).size.width * 0.06),
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
              ProfileWidget(),
              StatsWidget(),
              //InventoryWidget(),
              SizedBox(
                  height: MediaQuery.of(context).size.width * SCALE_SECTION),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08,
                    vertical: MediaQuery.of(context).size.width * 0.04),
                onTap: () {
                  Navigator.of(context).pushNamed(achievementsPage);
                },
                title: Text(ACHIEVEMENT_PAGE,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * SCALE_H3,
                        )),
              ),
              Divider(
                height: 0,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08,
                color: Theme.of(context).primaryColorDark,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08,
                    vertical: MediaQuery.of(context).size.width * 0.04),
                onTap: () {
                  Navigator.of(context).pushNamed(collectionsPage);
                },
                title: Text(COLLECTIONS_PAGE,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * SCALE_H3,
                        )),
              ),
              Divider(
                height: 0,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08,
                color: Theme.of(context).primaryColorDark,
              ),
              (authProvider.user.role == ADMINISTRADOR)
                  ? ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.08,
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      onTap: () {
                        Navigator.of(context).pushNamed(studioPage);
                      },
                      title: Text(
                        STUDIO_PAGE,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * SCALE_H3,
                            ),
                      ),
                    )
                  : SizedBox.shrink(),
              Divider(
                height: 0,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08,
                color: Theme.of(context).primaryColorDark,
              ),
              (authProvider.user.role == ADMINISTRADOR)
                  ? ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.08,
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      onTap: () {
                        Navigator.of(context).pushNamed(creatorPage);
                      },
                      title: Text(
                        CREATOR_PAGE,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width * SCALE_H3,
                            ),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                  height: MediaQuery.of(context).size.width * SCALE_SECTION),
              ShareAppWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
