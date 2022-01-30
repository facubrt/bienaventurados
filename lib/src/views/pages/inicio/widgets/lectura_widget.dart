import 'package:bienaventurados/src/logic/providers/avioncito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LecturaWidget extends StatelessWidget {
  const LecturaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avioncitoProvider = Provider.of<AvioncitoProvider>(context);
    avioncitoProvider.getLectura();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  avioncitoProvider.lectura,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.036,
                      ),
                ),
                Text(
                  avioncitoProvider.tituloLectura,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.036,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}