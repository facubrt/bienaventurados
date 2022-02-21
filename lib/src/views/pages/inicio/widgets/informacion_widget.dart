import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformacionWidget extends StatefulWidget {
  const InformacionWidget({Key? key}) : super(key: key);

  @override
  _InformacionWidgetState createState() => _InformacionWidgetState();
}

class _InformacionWidgetState extends State<InformacionWidget> {
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final infoProvider = Provider.of<InfoProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColorDark.withOpacity(0.05),
      child: Column(
        children: [
          Divider(
            height: 0,
            indent: MediaQuery.of(context).size.width * 0.08,
            endIndent: MediaQuery.of(context).size.width * 0.08,
            color: Theme.of(context).primaryColorDark,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefs.modoNoche
                      ? Image.asset(
                          'assets/images/isotipo-claro.png',
                          height: 60,
                          width: 60,
                        )
                      : Image.asset(
                          'assets/images/isotipo-oscuro.png',
                          height: 80,
                          width: 80,
                        ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          '${infoProvider.avCompartidos} avioncitos se\ncompartieron hoy',
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                        //SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                        // Text(
                        //   '25 avioncitos se\nconstruyeron hoy',
                        //   style: Theme.of(context).textTheme.headline5!.copyWith(
                        //     color: Theme.of(context).primaryColorDark,
                        //     fontSize: MediaQuery.of(context).size.width * 0.03,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
