import 'package:bienaventurados/src/views/widgets/titulo_seccion_widget.dart';
import 'package:flutter/material.dart';

class EvangelioWidget extends StatefulWidget {
  const EvangelioWidget({Key? key}) : super(key: key);

  @override
  State<EvangelioWidget> createState() => _EvangelioWidgetState();
}

class _EvangelioWidgetState extends State<EvangelioWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TituloSeccionWidget(titulo: 'Evangelio de hoy'),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: InkWell(
              onTap: () {
                print('TAP');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),),
                height: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
