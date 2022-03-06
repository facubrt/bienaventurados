import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            BLESSED_DAY_TITLE,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * SCALE_H2,
                  fontWeight: FontWeight.normal,
                ),
          ),
          Text(
            '${authProvider.usuario.nombre ?? ''}',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * SCALE_H2,
                ),
          ),
        ],
      ),
    );
  }
}
