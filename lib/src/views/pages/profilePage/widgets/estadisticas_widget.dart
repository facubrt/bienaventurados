import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstadisticasWidget extends StatelessWidget {
  const EstadisticasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas'.toUpperCase(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.01,
          ),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            height: MediaQuery.of(context).size.width * 0.01,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          Card(
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
                              'Avioncitos\ncompartidos'.toUpperCase(),
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
                              'Avioncitos\nconstruidos'.toUpperCase(),
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
                              'Constancia\nactual'.toUpperCase(),
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
                              'Tu mejor\nconstancia'.toUpperCase(),
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
        ],
      ),
    );
  }
}
