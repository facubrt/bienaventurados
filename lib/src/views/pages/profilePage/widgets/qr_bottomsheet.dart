import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/services/user_preferences.dart';
import 'package:flutter/material.dart';

Widget qrBottomSheet() {
  final prefs = UserPreferences();
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.center,
                child: prefs.darkMode
                    ? Image.asset(
                        QR_SHARE_NIGHT,
                        height: MediaQuery.of(context).size.width * 0.6,
                      )
                    : Image.asset(
                      QR_SHARE_DAY,
                      height: MediaQuery.of(context).size.width * 0.6,
                      ),
              ),
            ),
            Center(
              child: Text(
                QR_SHARE_TITLE,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.046,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Center(
                child: Text(
                  QR_SHARE_TEXT,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.036,
                        color: Theme.of(context).primaryColorDark,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(OK_BUTTON,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Theme.of(context).primaryColorDark,
                          )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  });
}
