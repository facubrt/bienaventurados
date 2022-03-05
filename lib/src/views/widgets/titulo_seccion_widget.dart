import 'package:flutter/material.dart';

class TituloSeccionWidget extends StatelessWidget {
  final String titulo;
  const TituloSeccionWidget({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          titulo.toUpperCase(),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.01,
        ),
        Container(
          color: Theme.of(context).colorScheme.secondary,
          height: MediaQuery.of(context).size.width * 0.01,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.04,
        ),
      ]),
    );
  }
}
