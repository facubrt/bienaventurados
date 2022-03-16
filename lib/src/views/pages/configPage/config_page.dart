import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;
  late PackageInfo packageInfo;
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  final _configList = [
    GENERAL_CONFIG,
    ACCOUNT_CONFIG,
    //LEGAL_CONFIG,
    SALIR,
  ];

  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  void getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            drawerProvider.openDrawer();
          },
          icon: Icon(Iconsax.category, size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
      body: ListView.separated(
          itemCount: _configList.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                navegateTo(index);
              },
              title: Text(
                _configList[index],
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0,
              indent: MediaQuery.of(context).size.width * 0.08,
              endIndent: MediaQuery.of(context).size.width * 0.08,
              color: Theme.of(context).primaryColorDark,
            );
          }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: versionInfoWidget(),
        ),
      ),
    );
  }

  Future<void> navegateTo(int pagina) async {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = UserPreferences();
    switch (_configList[pagina]) {
      case GENERAL_CONFIG:
        Navigator.of(context).pushNamed(generalConfigPage);
        break;
      case ACCOUNT_CONFIG:
        Navigator.of(context).pushNamed(accountConfigPage);
        break;
      case LEGAL_CONFIG:
        Navigator.of(context).pushNamed(legalPage);
        break;
      case SALIR:
        showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Iconsax.close_square,
                          size: MediaQuery.of(context).size.width * 0.06,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(REST_TIME_TITLE,
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.06)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      REST_TIME_TEXT,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  InkWell(
                    onTap: () {
                      authProvider.restoreConstancy();
                      paperplaneProvider.deleteAllData();
                      authProvider.signOut();
                      prefs.cleanPrefs();
                      prefs.darkMode = false;
                      Navigator.of(context).pushNamedAndRemoveUntil(bienaventuradosPage, (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(SALIR,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: MediaQuery.of(context).size.width * 0.03, color: Theme.of(context).primaryColorDark)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  Widget versionInfoWidget() {
    return Text(
      '$appName $version + $buildNumber'.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.028,
          ),
      textAlign: TextAlign.center,
    );
  }
}
