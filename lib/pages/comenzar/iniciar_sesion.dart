import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class IniciarSesionPage extends StatefulWidget {
  const IniciarSesionPage({Key? key}) : super(key: key);

  @override
  _IniciarSesionPageState createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  late bool ocultarPassword;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ocultarPassword = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4,),
                TextFormField(
                  controller: emailController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.headline1,
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Correo',
                    hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.headline1,
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  obscureText: ocultarPassword,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          ocultarPassword = !ocultarPassword;
                        });
                      },
                        child: ocultarPassword 
                        ? Icon(
                            FlutterIcons.eye_off_fea,
                            size: 28,
                            color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                          )
                        : Icon(
                            FlutterIcons.eye_fea,
                            size: 28,
                            color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                          )
                    ),
                    hintText: 'Contraseña',
                    hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                InkWell(
                  onTap: () async {
                    await authProvider.signInWithEmailAndPassword(emailController.text, passwordController.text);
                    SharedPrefs.guardarPrefs('sesionIniciada', true);
                    Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
                    //Navigator.of(context).pushNamedAndRemoveUntil(bienaventuradosPage, (route) => false);
                  },
                  child: Text('Iniciar sesión', style: Theme.of(context).textTheme.headline1!.copyWith(color: Theme.of(context).accentColor),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
