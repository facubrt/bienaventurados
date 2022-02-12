import 'package:bienaventurados/src/logic/providers/logro_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ComparteWidget extends StatelessWidget {
  const ComparteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      color: Theme.of(context).primaryColorDark.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 20.0, left: 20, right: 20.0, top: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Comparte con otros',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '¿Estás disfrutando de Bienaventurados? Comparte esta aventura con tus amigos para seguir creciendo en la fe juntos',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Text('Comparte esta aventura',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Theme.of(context).primaryColor,
                        )),
              ),
              onPressed: () async {
                final logroProvider =
                    Provider.of<LogroProvider>(context, listen: false);
                logroProvider.comprobacionLogros('compartir-app');
                await Share.share(
                    'https://play.google.com/store/apps/details?id=com.sereucaristia');
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            // TextButton(
            //   style: OutlinedButton.styleFrom(
            //     backgroundColor: Colors.transparent,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 10.0, vertical: 10.0),
            //     child: Text('Código QR',
            //         style: Theme.of(context).textTheme.subtitle1!.copyWith(
            //               fontSize: MediaQuery.of(context).size.width * 0.04,
            //               color: Theme.of(context).primaryColorDark,
            //             )),
            //   ),
            //   onPressed: () async {},
            // )
          ],
        ),
      ),
    );
  }
}
