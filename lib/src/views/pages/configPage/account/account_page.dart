import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SharedPreferences prefs;
  final InAppReview inAppReview = InAppReview.instance;

  final _configList = [
    UPDATE_NAME,
    UPDATE_EMAIL,
    // UPDATE_PASSWORD,
    DELETE_ACCOUNT,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //title: Text('Cuenta'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Iconsax.arrow_left,
            ),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: ListView.separated(
              itemCount: _configList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08,
                      vertical: MediaQuery.of(context).size.width * 0.04),
                  onTap: () {
                    navigateTo(index);
                  },
                  title: Text(_configList[index],
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * SCALE_H3,
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
        ));
  }

  Future<void> navigateTo(int pagina) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final paperplaneProvider =
        Provider.of<PaperplaneProvider>(context, listen: false);
    final prefs = UserPreferences();
    switch (_configList[pagina]) {
      case UPDATE_NAME:
        Navigator.of(context).pushNamed(updateNamePage);
        break;
      case UPDATE_EMAIL:
        Navigator.of(context).pushNamed(updateEmailPage);
        break;
      case UPDATE_PASSWORD:
        Navigator.of(context).pushNamed(updatePasswordPage);
        break;
      case DELETE_ACCOUNT:
        showFloatingModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DELETE_ACCOUNT_TITLE,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width * SCALE_H3)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Text(
                      DELETE_ACCOUNT_TEXT,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * SCALE_H4),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColorDark),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(CANCEL_BUTTON,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              SCALE_H4,
                                      color:
                                          Theme.of(context).primaryColorDark)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            paperplaneProvider.deleteAllData();
                            prefs.cleanPrefs();
                            prefs.darkMode = false;
                            authProvider.deleteUser();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                bienaventuradosPage, (route) => false);
                          },
                          child: Text(DELETE_BUTTON,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              SCALE_H4,
                                      color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }
}
