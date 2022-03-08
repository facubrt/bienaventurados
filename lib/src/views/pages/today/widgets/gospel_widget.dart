import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/views/widgets/section_widget.dart';
import 'package:flutter/material.dart';

class GospelWidget extends StatefulWidget {
  const GospelWidget({Key? key}) : super(key: key);

  @override
  State<GospelWidget> createState() => _GospelWidgetState();
}

class _GospelWidgetState extends State<GospelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionWidget(title: GOSPEL_SECTION),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: InkWell(
              onTap: () {
                print('TAP');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),),
                height: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
