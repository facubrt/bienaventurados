import 'package:flutter/material.dart';

class InformacionPage extends StatelessWidget {
  const InformacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
                "assets/images/isotipo-oscuro.png",
                height: 140,
                width: 140,
                color: Theme.of(context).primaryColorDark,
                isAntiAlias: true,
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
            child: Text(
              'Bienaventurados',
              style: Theme.of(context).textTheme.headline1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Ser Eucaristía',
              style: Theme.of(context).textTheme.headline4
            ),
          ),
        ],
      ),
    );
  }
}
