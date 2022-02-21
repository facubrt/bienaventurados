import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InformacionPage extends StatefulWidget {
  const InformacionPage({Key? key}) : super(key: key);

  @override
  State<InformacionPage> createState() => _InformacionPageState();
}

class _InformacionPageState extends State<InformacionPage> {
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
        title: Text('Acerca de'),
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
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/versiones/san-francisco-1-4.png',
                height: 140,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Bienaventurados',
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
                'Ser Eucaristía',
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
              child: versionInfoWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: oracionSanto(),
            ),
            Spacer(),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () async {
                      final String url = 'https://bienaventurados.web.app';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text('Página web'))),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  onPressed: () async {
                    final String url = 'https://twitter.com/sereucaristia';
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
                    final String url = 'https://instagram.com/sereucaristia';
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
                    final String url = 'https://facebook.com/sereucaristia';
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

  Widget versionInfoWidget() {
    return Text(
      'San Francisco de Asís $version + $buildNumber'.toUpperCase(),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.028,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget oracionSanto() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        '"Que el Señor te bendiga y te guarde, te muestre su rostro y otorgue su gracia, te mire benignamente y conceda la paz; que el Señor te bendiga."',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
      ),
    );
  }
}
