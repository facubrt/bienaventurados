import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/providers/avioncito_provider.dart';
import 'package:bienaventurados/widgets/modal_fit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:social_share/social_share.dart';

class ComparteWidget extends StatelessWidget {
  const ComparteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Toda aventura es más divertida con amigos. ¡Sé luz!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  //SocialShare.copyToClipboard("https://bienaventurados.web.app/comparte");
                },
                tileColor: Theme.of(context).primaryColorDark.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                title: Text('https://bienaventurados.web.app/comparte', style: Theme.of(context).textTheme.button!.copyWith(color: Theme.of(context).primaryColorDark.withOpacity(0.4), fontSize: 14),),
                trailing: Icon(FlutterIcons.copy_fea, size: 20, color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
              ),
              SizedBox(height: 40),
              InkWell(
                child: Text('Comparte'.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () async {
                   await Share.share('https://bienaventurados.web.app/comparte' );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
