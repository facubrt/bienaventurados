import 'package:bienaventurados/src/utils/constants.dart';
import 'package:bienaventurados/src/views/widgets/section_widget.dart';
import 'package:flutter/material.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionWidget(title: INSTRUCTIONS_SECTION),
          Container(
            height: MediaQuery.of(context).size.width * 0.6,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              instructionsForFlying(context),
              instructionsForBuilding(context),
              instructionsForSharing(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget instructionsForFlying(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 30.0),
        child: InkWell(
          onTap: () {
            print('TAP');
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    INSTRUCTIONS_FOR_SHARING_TITLE,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * SPACE_SECTION),
                  Text(
                    INSTRUCTIONS_FOR_FLYING_SUBTITLE,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
          ),
        ),
      ),
    );
  }

  Widget instructionsForBuilding(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
        child: InkWell(
          onTap: () {
        print('TAP');
      },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    INSTRUCTIONS_FOR_BUILDING_TITLE,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    INSTRUCTIONS_FOR_BUILDING_SUBTITLE,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
          ),
        ),
      ),
    );
  }

  Widget instructionsForSharing(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 15.0),
        child: InkWell(
          onTap: () {
        print('TAP');
      },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    INSTRUCTIONS_FOR_SHARING_TITLE,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_H3,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * SPACE_SECTION),
                  Text(
                    INSTRUCTIONS_FOR_SHARING_SUBTITLE,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * SCALE_BODY,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
          ),
        ),
      ),
    );
  }
}
