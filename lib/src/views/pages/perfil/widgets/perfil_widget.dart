import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilWidget extends StatefulWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  _PerfilWidgetState createState() => _PerfilWidgetState();
}

class _PerfilWidgetState extends State<PerfilWidget> {
  late int _imagenPerfil;
  late String? nombre;

  List images = [
    'perfil-01',
    'perfil-02',
    'perfil-03',
    'perfil-04',
    'perfil-05',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    final authProvider = Provider.of<AuthProvider>(context);
    nombre = authProvider.usuario.nombre;
    // final authProvider = Provider.of<AuthProvider>(context);
    _imagenPerfil = prefs.imagenPerfil;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                if (_imagenPerfil < (images.length - 1)) {
                  _imagenPerfil += 1;
                } else {
                  _imagenPerfil = 0;
                }
                prefs.imagenPerfil = _imagenPerfil;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(18),
              //     border: Border.all(
              //         width: 4, color: Theme.of(context).primaryColorDark)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/perfil/${images[_imagenPerfil]}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.06,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre ?? '',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    '¡Bienaventurado seas!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  //nivelWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nivelWidget() {
    final widthExperience = MediaQuery.of(context).size.width - 300;
    final experience = widthExperience / 2;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nivel 3', 
          style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                    ),
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary),
                    height: 10,
                    width: experience,
                  ),
                ]),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '128 / 500',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              )
            ],
          ),
        ],
    );
  }
}
