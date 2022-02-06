import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/data/datasources/local/meses_data.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:bienaventurados/src/views/pages/inicio/avioncito_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvioncitoWidget extends StatelessWidget {
  const AvioncitoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            shadowColor: Theme.of(context).shadowColor,
            color: Theme.of(context).colorScheme.secondary,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(alignment: Alignment.topCenter, children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/isotipo-claro.png',
                        height: 60,
                        width: 60,
                      ),
                      Spacer(),
                      Text('Un mensaje muy especial está esperándote...',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colores.primarioDay)),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          print('TAP');
                          Navigator.of(context).pushNamed(avioncitoPage,
                              arguments: avioncitoProvider.avioncito);
                          // Navigator.of(context).pushNamed(avioncitoPage);
                          // if (!avioncitoProvider.hoy!.visto!) {
                          //   print('descubriste este avioncito');
                          //   avioncitoProvider.actualizarDia(authProvider.user.correo);
                          // } else {
                          //   print('ya descubriste este avioncito');
                          // }
                          // Navigator.of(context).pushNamed(diaPage, arguments: avioncitoProvider.hoy);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colores.primarioDay,
                        ),
                        child: Text(
                          'Descubre',
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
