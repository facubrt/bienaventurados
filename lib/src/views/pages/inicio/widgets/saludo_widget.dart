import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaludoWidget extends StatefulWidget {
  const SaludoWidget({Key? key}) : super(key: key);

  @override
  State<SaludoWidget> createState() => _SaludoWidgetState();
}

class _SaludoWidgetState extends State<SaludoWidget> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bendecido día,',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.normal,
                ),
          ),
          Text(
            '${authProvider.usuario.nombre ?? ''}',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                ),
          ),
        ],
      ),
    );
  }
}
