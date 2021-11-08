import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InformacionPage extends StatelessWidget {
  const InformacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              child: Text('Carlo Acutis (beato) ver. 1.3.0',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.04)),
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
                child: Text('Página web')
              
              )
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.06,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
}
