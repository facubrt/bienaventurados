import 'package:bienaventurados/src/utils/constants.dart';
import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  const SectionWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.width * SCALE_SECTION,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * SPACE_MIN,
        ),
        Container(
          color: Theme.of(context).colorScheme.secondary,
          height: MediaQuery.of(context).size.width * 0.01,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * SPACE_SECTION,
        ),
      ]),
    );
  }
}
