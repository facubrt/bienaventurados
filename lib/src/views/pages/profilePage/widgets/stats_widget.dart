import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:bienaventurados/src/views/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionWidget(title: STATS_SECTION),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Card(
            elevation: 0,
            color: ColorPalette.accentDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          authProvider.user.avCompartidos.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: ColorPalette.primaryLight,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                              ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              PAPERPLANES_SHARED.toUpperCase(),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    color: ColorPalette.primaryLight,
                                    fontSize: MediaQuery.of(context).size.width * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          authProvider.user.avConstruidos.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: ColorPalette.primaryLight,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                              ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              PAPERPLANES_BUILDED.toUpperCase(),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    color: ColorPalette.primaryLight,
                                    fontSize: MediaQuery.of(context).size.width * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          authProvider.user.actualConstancia.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: ColorPalette.primaryLight,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                              ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                             CONSTANCY.toUpperCase(),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    color: ColorPalette.primaryLight,
                                    fontSize: MediaQuery.of(context).size.width * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          authProvider.user.mejorConstancia.toString().padLeft(2, '0'),
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: ColorPalette.primaryLight,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                              ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              BEST_CONSTANCY.toUpperCase(),
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                    color: ColorPalette.primaryLight,
                                    fontSize: MediaQuery.of(context).size.width * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ),
        ),
      ],
    );
  }
}
