import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Availability { loading, available, unavailable }

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  late SharedPreferences prefs;
  final InAppReview _inAppReview = InAppReview.instance;
  //Availability _availability = Availability.loading;
  String _appStoreId = '';
  String _microsoftStoreId = '';

  final _configList = [
    NOTIFICATIONS_CONFIG,
    THEME_CONFIG,
    RATINGS_CONFIG,
    //'Reporta un error',
    ABOUT_CONFIG,
  ];

  // void _setAppStoreId(String id) => _appStoreId = id;

  // void _setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  //Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: _appStoreId,
        microsoftStoreId: _microsoftStoreId,
      );

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   try {
    //     final isAvailable = await _inAppReview.isAvailable();

    //     setState(() {
    //       _availability = isAvailable && !Platform.isAndroid ? Availability.available : Availability.unavailable;
    //     });
    //   } catch (e) {
    //     setState(() => _availability = Availability.unavailable);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Text(GENERAL_CONFIG),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: ListView.separated(
          itemCount: _configList.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: MediaQuery.of(context).size.width * 0.04),
              onTap: () {
                navigateTo(index);
              },
              title: Text(_configList[index],
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
                height: 0,
                color: Theme.of(context).primaryColorDark,
                indent: MediaQuery.of(context).size.width * 0.08,
                endIndent: MediaQuery.of(context).size.width * 0.08);
          }),
    );
  }

  Future<void> navigateTo(int pagina) async {
    switch (_configList[pagina]) {
      case NOTIFICATIONS_CONFIG:
        Navigator.of(context).pushNamed(notiConfigPage);
        break;
      case THEME_CONFIG:
        Navigator.of(context).pushNamed(themeConfigPage);
        break;
      case RATINGS_CONFIG:
        final achievementProvider = Provider.of<AchievementProvider>(context, listen: false);
        achievementProvider.achievementsCheck(ACHIEVEMENT_RATING_APP);
        //if (await _inAppReview.isAvailable()) {
        //if (_availability == Availability.available) {
        //  print('CALIFICAR');
          //_requestReview();
        //   _inAppReview.requestReview();
        // }
        if (await _inAppReview.isAvailable()) {
          _openStoreListing();
        }
        break;
      case ABOUT_CONFIG:
        Navigator.of(context).pushNamed(informationPage);
        break;
      default:
        break;
    }
  }
}
