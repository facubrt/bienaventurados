import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:flutter/material.dart';

class EstadisticasWidget extends StatelessWidget {
  const EstadisticasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 0,
        color: Colores.secundarioNight,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '126',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Avioncitos\ncompartidos',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '36',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Avioncitos\nconstruidos',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '36',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Constancia\nactual',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '58',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      'Tu mejor\nconstancia',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colores.primarioDay,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
