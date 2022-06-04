import 'package:bienaventurados/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalPage extends StatefulWidget {
  const LegalPage({Key? key}) : super(key: key);

  @override
  _LegalPageState createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  final _configList = [
    PRIVACY_POLICY,
    TERMS_OF_SERVICE,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
                  indent: MediaQuery.of(context).size.width * 0.08,
                  endIndent: MediaQuery.of(context).size.width * 0.08,
                  color: Theme.of(context).primaryColorDark,
                );
              }),
        ));
  }

  Future<void> navigateTo(int pagina) async {
    switch (pagina) {
      case 0:
        final String url = PRIVACY_POLICY_LINK;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 1:
        final String url = TERMS_OF_SERVICE_LINK;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      default:
        break;
    }
  }
}
