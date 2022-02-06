import 'package:flutter/material.dart';

class SaludoWidget extends StatelessWidget {
  const SaludoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bendecido día,',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
          ),
          Text(
            'Facundo',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
          ),
        ],
      ),
    );
  }
}
