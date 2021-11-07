import 'package:bienaventurados/providers/auth_provider.dart';
import 'package:bienaventurados/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class ComenzarPage extends StatefulWidget {
  const ComenzarPage({Key? key}) : super(key: key);

  @override
  _ComenzarPageState createState() => _ComenzarPageState();
}

class _ComenzarPageState extends State<ComenzarPage> {
  
  final emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Form(
      key: emailFormKey,
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ingresa tu correo', style: Theme.of(context).textTheme.headline2!.copyWith(
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
          padding: const EdgeInsets.all(40.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                if (emailFormKey.currentState!.validate()) {
                  //authProvider.validarCorreo(emailController.text).then((correoExistente) {
                    //if(correoExistente) {
                      print('EL CORREO EXISTE, HOLA DE NUEVO');
                      Navigator.of(context).pushNamed(iniciarSesionPage);
                    //} else {
                      //print('EL CORREO NO EXISTE, BIENVENIDO');
                      //Navigator.of(context).pushNamed(registrarsePage);
                    //}
                  //});
                  // pageController.nextPage(
                  //     duration: Duration(milliseconds: 300),
                  //     curve: Curves.fastLinearToSlowEaseIn);
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
    ),
    );
  }
}
