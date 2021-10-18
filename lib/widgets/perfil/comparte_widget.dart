import 'package:flutter/material.dart';

class ComparteWidget extends StatelessWidget {
  const ComparteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Toda aventura es mejor con amigos. Animate a compartir este camino con otros y sé luz ahí donde vayas.',
                style:
                    Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                child: Text('Comparte'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1),
                onTap: () {
                  print('tap');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
