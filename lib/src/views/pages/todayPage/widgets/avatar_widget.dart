import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/data/local/drawer_items.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({ Key? key }) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    final prefs = UserPreferences();
    int _imgProfile = prefs.imgProfile;
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          drawerProvider.page = DrawerItems.profilePage;
          Navigator.of(context).pushReplacementNamed(dashboardPage);
        },
        child: Container(
          height: MediaQuery.of(context).size.width * DIMENSION_AVATAR,
          width: MediaQuery.of(context).size.width * DIMENSION_AVATAR,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_AVATAR),
            child: Image.asset(
              'assets/images/perfil/perfil-0${_imgProfile + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}