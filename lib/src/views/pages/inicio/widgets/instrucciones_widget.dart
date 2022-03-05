import 'package:bienaventurados/src/views/widgets/titulo_seccion_widget.dart';
import 'package:flutter/material.dart';

class InstruccionesWidget extends StatelessWidget {
  const InstruccionesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TituloSeccionWidget(titulo: 'Instrucciones'),
          Container(
            height: MediaQuery.of(context).size.width * 0.6,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              instruccionesHacerVolar(context),
              instruccionesConstruir(context),
              instruccionesCompartir(context),
            ]),
          ),
        ],
      ),
    );
  }

  Widget instruccionesHacerVolar(BuildContext context) {
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
                    'Instrucciones para hacer volar',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    '(o de cómo sacar a pasear los avioncitos por muchos corazones y lugares)',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget instruccionesConstruir(BuildContext context) {
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
                    'Instrucciones para construir',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    '(o de cómo encender un corazón y abrazar al otro construyendo un mundo de esperanza)',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget instruccionesCompartir(BuildContext context) {
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
                    'Instrucciones para compartir',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    '(o de cómo ser luz y compartir la fe para que el amor de Dios llegue a todas partes)',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
