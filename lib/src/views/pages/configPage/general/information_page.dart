import 'package:bienaventurados/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  late PackageInfo packageInfo;
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    getPackageInfo();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //title: Text('Acerca de'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   alignment: Alignment.center,
            //   child: Image.asset(
            //     'assets/images/versiones/san-francisco-1-4.png',
            //     height: 140,
            //   ),
            // ),
            //SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: Text(
                TITLE_APP,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: Text(
                AUTHOR,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: aboutSE(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: versionInfoWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: saintPrayer(),
            ),
            Spacer(),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () async {
                      final String url = WEBSITE_LINK;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(WEBSITE_TEXT))),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () async {
                    final String url = TWITTER_LINK;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icon(FlutterIcons.twitter_mco),
                ),
                IconButton(
                  onPressed: () async {
                    final String url = INSTAGRAM_LINK;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icon(FlutterIcons.instagram_mco),
                ),
                IconButton(
                  onPressed: () async {
                    final String url = FACEBOOK_LINK;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icon(FlutterIcons.facebook_box_mco),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

    Widget aboutSE() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        ABOUT_SE,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
      ),
    );
  }

  Widget versionInfoWidget() {
    return Text(
      'San Francisco de Asís $version + $buildNumber'.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.028,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget saintPrayer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        SAINT_PRAYER,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
      ),
    );
  }
}
