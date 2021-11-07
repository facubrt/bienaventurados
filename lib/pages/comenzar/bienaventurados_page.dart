import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BienaventuradosPage extends StatelessWidget {
  const BienaventuradosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
            // Spacer(),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(iniciarSesionPage);
            //   },
            //   child: Text('Iniciar sesión',
            //       style: Theme.of(context).textTheme.headline1!.copyWith(
            //         fontSize: MediaQuery.of(context).size.width * 0.06,
            //       )),
            //   splashColor: Colors.transparent,
            // ),
            // SizedBox(height: 40),
            // InkWell(
              
            //   onTap: () {
            //     Navigator.of(context).pushNamed(registrarsePage);
            //   },
            //   child: Text('Registrarse',
            //       style: Theme.of(context).textTheme.headline1!.copyWith(
            //         fontSize: MediaQuery.of(context).size.width * 0.06,
            //       )),
            //   splashColor: Colors.transparent,
            // )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(iniciarSesionPage);
                },
                child: Text('Iniciar Sesión',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Theme.of(context).primaryColor)),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.04),
            Container(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
                  backgroundColor: Theme.of(context).primaryColor,
                  
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(registrarsePage);
                },
                child: Text('Registrarse',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Theme.of(context).primaryColorDark)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
