import 'package:flutter/material.dart';

class InformacionWidget extends StatefulWidget {
  const InformacionWidget({Key? key}) : super(key: key);

  @override
  _InformacionWidgetState createState() => _InformacionWidgetState();
}

class _InformacionWidgetState extends State<InformacionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColorDark.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/isotipo-oscuro.png',
                height: 60,
                width: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(child: Text('25 avioncitos se compartieron hoy')),
            ],
          ),
        ),
      ),
    );
  }
}
