import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:flutter/material.dart';

Widget qrBottomSheet() {
  final prefs = PreferenciasUsuario();
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.center,
                child: prefs.modoNoche
                    ? Image.asset(
                        'assets/images/qr-compartir-claro.png',
                        height: MediaQuery.of(context).size.width * 0.4,
                      )
                    : Image.asset('assets/images/qr-compartir-claro.png'),
              ),
            ),
            Center(
              child: Text(
                'Comparte este código QR',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.046,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Center(
                child: Text(
                  'Haz que tus amigos y familiares escaneen el código QR de arriba utilizando la cámara de su teléfono para acceder a Bienaventurados',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.036,
                        color: Theme.of(context).primaryColorDark,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text('Listo',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Theme.of(context).primaryColorDark,
                          )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  });
}
