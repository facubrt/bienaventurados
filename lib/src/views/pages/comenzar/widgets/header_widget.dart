import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
          ],
        );
  }
}