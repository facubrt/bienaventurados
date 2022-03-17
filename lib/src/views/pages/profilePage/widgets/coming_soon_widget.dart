import 'package:bienaventurados/src/constants/constants.dart';
import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({ Key? key }) : super(key: key);

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
              Text(COMING_SOON, style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
              Text(COMING_SOON_TEXT, style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}