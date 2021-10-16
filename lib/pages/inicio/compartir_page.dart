import 'package:flutter/material.dart';

class CompartirPage extends StatefulWidget {
  const CompartirPage({Key? key}) : super(key: key);

  @override
  _CompartirPageState createState() => _CompartirPageState();
}

class _CompartirPageState extends State<CompartirPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
      children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(border: Border.all(width: 4, color: Theme.of(context).primaryColorDark)),
            height: MediaQuery.of(context).size.height /1.4,
            width: MediaQuery.of(context).size.width /1.2,
          ),
          SizedBox(height: 60),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child:
                    Text('Compartir', style: Theme.of(context).textTheme.headline2),
              ),
              Spacer(),
              InkWell(
            onTap: () {},
            child:
                Text('Guardar', style: Theme.of(context).textTheme.headline2),
          ),
            ],
          ),
          
      ],
    ),
        ));
  }
}
