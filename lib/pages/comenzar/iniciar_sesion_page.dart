import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class IniciarSesionPage extends StatefulWidget {
  const IniciarSesionPage({Key? key}) : super(key: key);

  @override
  State<IniciarSesionPage> createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final passwordFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  late bool ocultarPassword;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    ocultarPassword = true;
  }

  @override
  void dispose() {
    passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          emailPage(),
          passwordPage(),
        ],
      ),
    );
  }

  Widget emailPage() {
    return Form(
      key: emailFormKey,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingresa un correo', style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.06,)
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
              TextFormField(
                controller: emailController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.06,),
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'correo',
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Theme.of(context)
                          .primaryColorDark
                          .withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if(!value!.contains('@')) {
                    return 'Debes ingresar un correo para continuar';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  
                ),
              onPressed: () {
                if (emailFormKey.currentState!.validate()) {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              child: Text('Continuar',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordPage() {

    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            '¡Oh, oh! Parece que los datos ingresados no son correctos. Intentalo de nuevo o registrate para comenzar una nueva aventura.',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    final authProvider = Provider.of<AuthProvider>(context);
    final prefs = PreferenciasUsuario();
    return Form(
      key: passwordFormKey,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingresa una contraseña para iniciar', style: Theme.of(context).textTheme.headline2!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.06,)
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.04,),
              TextFormField(
                controller: passwordController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.06,),
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
                            size: MediaQuery.of(context).size.width * 0.06,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.2),
                          )
                        : Icon(
                            FlutterIcons.eye_fea,
                            size: MediaQuery.of(context).size.width * 0.06,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.2),
                          )),
                  hintText: 'contraseña',
                  hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                      color: Theme.of(context)
                          .primaryColorDark
                          .withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar una contraseña para continuar';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  
                ),
              onPressed: () {
                if (passwordFormKey.currentState!.validate()) {
                  authProvider.signInWithEmailAndPassword(emailController.text, passwordController.text).then((resultado) {
                    if (resultado != null) {
                    prefs.sesionIniciada = true;
                    Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
                    } else {
                      //ACA SE PUEDE REDIRECCIONAR A REGISTRAR PARA HACERLO SI NO ESTÁ REGISTRADO.
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  });
                }
              },
              child: Text('Continuar',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
