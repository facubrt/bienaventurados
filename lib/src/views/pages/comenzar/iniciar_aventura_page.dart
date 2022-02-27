import 'package:bienaventurados/src/logic/providers/auth_provider.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class IniciarAventuraPage extends StatefulWidget {
  const IniciarAventuraPage({Key? key}) : super(key: key);

  @override
  State<IniciarAventuraPage> createState() => _IniciarAventuraPageState();
}

class _IniciarAventuraPageState extends State<IniciarAventuraPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final passwordFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  late bool ocultarPassword;

  final PageController _pageController = PageController(initialPage: 0);

  // Boton de carga
  int _state = 0;

  @override
  void initState() {
    super.initState();
    ocultarPassword = true;
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Comenzar aventura'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Iconsax.arrow_left,
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          emailPage(),
          passwordPage(),
          namePage(),
        ],
      ),
    );
  }

  Widget emailPage() {
    return Form(
      key: emailFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Qué correo deseas utilizar?',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                controller: emailController,
                autofocus: false,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'correo',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (!value!.contains('@')) {
                    return 'Debes ingresar un correo válido para continuar';
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
                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
                }
              },
              child: Text('Continuar',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: MediaQuery.of(context).size.width * 0.04, color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordPage() {
    return Form(
      key: passwordFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingresa una contraseña',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                  controller: passwordController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
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
                                Iconsax.eye_slash,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                              )
                            : Icon(
                                Iconsax.eye,
                                size: MediaQuery.of(context).size.width * 0.06,
                                color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                              )),
                    hintText: 'contraseña',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
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
                    } else if (value.length < 8) {
                      return 'La contraseña debe contener más de 8 caracteres';
                    } else {
                      return null;
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    recuperarCuenta();
                  },
                  child: Text('¿Olvidaste tu contraseña?'),
                ),
              )
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
                child: setUpButtonChild(),
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (passwordFormKey.currentState!.validate()) {
                    setState(() {
                      if (_state == 0) {
                        _state = 1;
                        iniciarCuenta();
                      }
                    });
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget namePage() {
    return Form(
      key: nameFormKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comienza tu aventura,',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextFormField(
                controller: nameController,
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
                cursorColor: Theme.of(context).primaryColorDark,
                cursorWidth: 4,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'nombre',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: MediaQuery.of(context).size.width * 0.06, color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes ingresar un nombre para continuar';
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
                if (nameFormKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (nameFormKey.currentState!.validate()) {
                    setState(() {
                      if (_state == 0) {
                        _state = 1;
                        registrarCuenta();
                      }
                    });
                  }
                }
              },
              child: setUpButtonChild(),
            ),
          ),
        ),
      ),
    );
  }

  // BOTON DE CARGA
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Continuar",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ));
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void recuperarCuenta() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('¡No te preocupes! Hemos enviado un correo a ${emailController.text} para que puedas restablecer tu contraseña.',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );
    authProvider.recuperarCuenta(emailController.text);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void iniciarCuenta() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();

    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('¡Oh, oh! Parece que algo no salió bien. Intentalo de nuevo.',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    authProvider.signInWithEmailAndPassword(emailController.text, passwordController.text).then((resultado) {
      if (resultado == 'user-found') {
        prefs.sesionIniciada = true;
        Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
      } else if (resultado == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          _state = 0;
        });
      } else if (resultado == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        setState(() {
          _state = 0;
        });
      } else if (resultado == 'user-not-found') {
        setState(() {
          _state = 0;
        });
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }

  void registrarCuenta() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final prefs = PreferenciasUsuario();

    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('¡Oh, oh! Parece que algo no salió bien. Intentalo de nuevo.',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Theme.of(context).primaryColor,
                )),
      ),
    );

    authProvider.createUserWithEmailAndPassword(nameController.text, emailController.text, passwordController.text).then((resultado) {
      if (resultado != null) {
        prefs.sesionIniciada = true;
        Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });
  }
}
