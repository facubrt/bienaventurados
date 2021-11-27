import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ComparteWidget extends StatelessWidget {
  const ComparteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        //borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Toda aventura es más divertida con amigos. ¡Sé luz!',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04,),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20),
              InkWell(
                child: Text('Comparte'.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.035,)),
                onTap: () async {
                   await Share.share('https://play.google.com/store/apps/details?id=com.sereucaristia' );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
