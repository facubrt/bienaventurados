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
            Text('B', style: TextStyle(fontSize: 68, fontFamily: 'Montserrat', fontStyle: FontStyle.normal, fontWeight: FontWeight.w900)),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(iniciarSesionPage);
              },
              child: Text('Iniciar sesión', style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(registrarsePage);
              },
              child: Text('Registrarse', style: Theme.of(context).textTheme.headline1),
            )
          ],
        ),
      ),
    );
  }
}
