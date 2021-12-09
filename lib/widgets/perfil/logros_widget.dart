import 'package:flutter/material.dart';

class LogrosWidget extends StatefulWidget {
  const LogrosWidget({ Key? key }) : super(key: key);

  @override
  _LogrosWidgetState createState() => _LogrosWidgetState();
}

class _LogrosWidgetState extends State<LogrosWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
          child: Column(
          children: [
            Text('Tu progreso', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index){
                return Card(color: Colors.red,);
              }),
          ],
        ),
      ),),
    );
  }
}