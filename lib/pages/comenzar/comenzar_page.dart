import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';

class ComenzarPage extends StatelessWidget {
  const ComenzarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/isotipo.png",
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              color: Theme.of(context).primaryColorDark,
              isAntiAlias: true,
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(iniciarSesionPage);
              },
              child: Text('Iniciar sesión',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  )),
              splashColor: Colors.transparent,
            ),
            SizedBox(height: 40),
            InkWell(
              
              onTap: () {
                Navigator.of(context).pushNamed(registrarsePage);
              },
              child: Text('Registrarse',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  )),
              splashColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
