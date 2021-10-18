import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/repositories/shared_prefs.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class RegistrarsePage extends StatefulWidget {
  const RegistrarsePage({Key? key}) : super(key: key);

  @override
  _RegistrarsePageState createState() => _RegistrarsePageState();
}

class _RegistrarsePageState extends State<RegistrarsePage> {
  late bool ocultarPassword;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
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
    nameController.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4,),
                TextFormField(
                  controller: nameController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline1,
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    hintStyle: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColorDark.withOpacity(0.2)),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  validator: (value) {
                          if(value!.isEmpty) {
                            return 'Debes ingresar un nombre para continuar';
                          } else {
                            return null;
                          }
                        },
                ),
                SizedBox(height: 20),
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
                  validator: (values) {
                          if(!values!.contains('@')) {
                            return 'Ingresa un correo válido';
                          } else {
                            return null;
                          } 
                        },
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
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                              )
                            : Icon(
                                FlutterIcons.eye_fea,
                                size: 28,
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                              )),
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
                  validator: (values) {
                          if(values!.length < 8) {
                            return 'Debe contener más de 8 caracteres';
                          } else {
                            return null;
                          }
                        },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                InkWell(
                  onTap: () async {
                    if(formKey.currentState!.validate()) {
                        await authProvider.createUserWithEmailAndPassword(nameController.text, emailController.text, passwordController.text);
                        SharedPrefs.guardarPrefs('sesionIniciada', true);
                        FirebaseInAppMessaging.instance.triggerEvent('primera_sesion_iniciada');
                        Navigator.of(context).pushNamedAndRemoveUntil(dashboardPage, (route) => false);
                    }},
                  child: Text(
                    'Registrarse',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                  splashColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
