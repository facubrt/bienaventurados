import 'package:flutter/material.dart';

class ProximamenteWidget extends StatelessWidget {
  const ProximamenteWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          
          decoration: BoxDecoration(color: Theme.of(context).primaryColorDark.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Muy pronto...', style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
              Text('Muchas más colecciones están en camino. ¡Vuelve pronto!', style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}