import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvioncitoWidget extends StatelessWidget {
  const AvioncitoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text('Esto es para vos',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.04,
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          shadowColor: Theme.of(context).shadowColor,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(alignment: Alignment.topCenter, children: [
              Positioned.fill(
                child: Container(
                  color: Colors.blue,
                )
              ),
              Positioned.fill(
                  child: Container(
                color: Theme.of(context).primaryColorDark.withOpacity(0.4),
              )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hoy',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colores.primarioDay)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                    Text('Un mensaje muy especial está esperándote...',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colores.primarioDay)),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(avioncitoPage, arguments: avioncitoProvider.avioncito);
                          // if (!avioncitoProvider.hoy!.visto!) {
                          //   print('descubriste este avioncito');
                          //   avioncitoProvider.actualizarDia(authProvider.user.correo);
                          // } else {
                          //   print('ya descubriste este avioncito');
                          // }
                          // Navigator.of(context).pushNamed(diaPage, arguments: avioncitoProvider.hoy);
                        },
                        style: Theme.of(context)
                            .textButtonTheme
                            .style!
                            .copyWith(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                StadiumBorder(
                                  side: BorderSide(
                                      width: 1, color: Colores.primarioDay),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).accentColor.withOpacity(0)),
                            ),
                        child: Text('Descubre',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colores.primarioDay)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}