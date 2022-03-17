import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/views/pages/profilePage/widgets/qr_bottomsheet.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ShareAppWidget extends StatelessWidget {
  const ShareAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20.0, top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                SHARE_APP_TITLE,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                SHARE_APP_TEXT,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  SHARE_APP_BTN,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: ColorPalette.primaryLight,
                  ),
                ),
              ),
              onPressed: () async {
                final logroProvider = Provider.of<AchievementProvider>(context, listen: false);
                logroProvider.achievementsCheck(ACHIEVEMENT_SHARE_APP);
                await Share.share(PLAY_STORE_LINK);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Text(QR_SHARE_BTN,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Theme.of(context).primaryColorDark,
                        )),
              ),
              onPressed: () async {
                showFloatingModalBottomSheet<bool?>(
                    backgroundColor: Theme.of(context).primaryColor,
                    context: context,
                    builder: (context) {
                      return qrBottomSheet();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
