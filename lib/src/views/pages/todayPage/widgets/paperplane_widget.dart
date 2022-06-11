import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/utils/routes.dart';
import 'package:bienaventurados/src/data/local/months_data.dart';
import 'package:bienaventurados/src/views/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PaperplaneWidget extends StatelessWidget {
  const PaperplaneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paperplaneProvider = Provider.of<PaperplaneProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionWidget(title: PAPERPLANE_SECTION),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * DIMENSION_PAPERPLANE,
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/paperplanes/background/${paperplaneProvider.background}.png',
                        height: MediaQuery.of(context).size.height *
                            DIMENSION_PAPERPLANE,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.asset(
                      'assets/images/av-hoy.png',
                    ),
                    // Image.asset(
                    //   'assets/images/paperplanes/pattern/${paperplaneProvider.pattern}.png',
                    // ),
                    // Image.asset(
                    //   'assets/images/paperplanes/base/${paperplaneProvider.base}.png',
                    // ),
                    // Image.asset(
                    //   'assets/images/paperplanes/wings/${paperplaneProvider.wings}.png',
                    // ),
                    // Image.asset(
                    //   'assets/images/paperplanes/stamp/${paperplaneProvider.stamp}.png',
                    // ),
                    // Image.asset(
                    //   'assets/images/paperplanes/detail/${paperplaneProvider.detail}.png',
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Image.asset(
                              //   ISOTYPE_LIGHT,
                              //   height: MediaQuery.of(context).size.width *
                              //       DIMENSION_ISOTYPE,
                              //   width: MediaQuery.of(context).size.width *
                              //       DIMENSION_ISOTYPE,
                              // ),
                              Spacer(),
                              Text(
                                '${DateTime.now().day} ${Months.allMonths[DateTime.now().month - 1].id.substring(0, 3)}\n${DateTime.now().year}'
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                SCALE_H4,
                                        color: ColorPalette.primaryLight),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          Spacer(),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Chip(
                          //     visualDensity: VisualDensity.comfortable,
                          //     label: Text(avioncitoProvider.avioncito!.tag!.toUpperCase(),
                          //         style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          //             fontSize: MediaQuery.of(context).size.width * 0.025,
                          //             fontWeight: FontWeight.bold,
                          //             color: Colores.acento)),
                          //     backgroundColor: Colores.primarioDay.withOpacity(0.9),
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width *
                                SPACE_SECTION,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DISCOVERY_TITLE,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: ColorPalette.primaryLight,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                SCALE_H3,
                                          ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              SPACE_SECTION,
                                    ),
                                    Text(
                                      DISCOVERY_TEXT,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: ColorPalette.primaryLight,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                SCALE_H4,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.height *
                                      0.04),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                child: IconButton(
                                  icon: Icon(
                                    Iconsax.play,
                                    color: ColorPalette.primaryLight,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        paperplanePage,
                                        arguments:
                                            paperplaneProvider.paperplane);
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
