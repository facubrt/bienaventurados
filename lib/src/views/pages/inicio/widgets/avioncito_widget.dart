import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AvioncitoWidget extends StatelessWidget {
  const AvioncitoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16)),
        height: MediaQuery.of(context).size.height * 0.64,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/isotipo-claro.png',
                      height: 60,
                      width: 60,
                    ),
                    Spacer(),
                    Text(
                      '${DateTime.now().day} ${MesesData.meses[DateTime.now().month - 1].id.substring(0, 3)}\n${DateTime.now().year}'
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Colores.primarioDay),
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
                SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Esto es para vos',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colores.primarioDay,
                              fontSize: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
                          Text(
                            'Descubre este avioncito y dejate abrazar por sus palabras',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colores.primarioDay,
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                      IconButton(
                        icon: Icon(
                          Iconsax.play,
                          color: Colores.primarioDay,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(avioncitoPage, arguments: avioncitoProvider.avioncito);
                        },
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
