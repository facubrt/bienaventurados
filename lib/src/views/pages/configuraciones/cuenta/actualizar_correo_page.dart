import 'package:bienaventurados/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ActualizarCorreoPage extends StatefulWidget {

  const ActualizarCorreoPage({Key? key,}) : super(key: key);

  @override
  _ActualizarCorreoPageState createState() => _ActualizarCorreoPageState();
}

class _ActualizarCorreoPageState extends State<ActualizarCorreoPage> {
  final TextEditingController _correoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Actualizar Correo'),
        leading: InkWell(
          onTap: () {Navigator.of(context).pop();},
          child: Icon(
            Iconsax.arrow_left,
            
            ),
        ),
      ),
      body: actualizarNombreWidget(),
    );
  }

  Widget actualizarNombreWidget() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text('¿Te gustaría actualizar tu correo?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                TextFormField(
                  controller: _correoController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                  cursorColor: Theme.of(context).primaryColorDark,
                  cursorWidth: 4,
                  decoration: InputDecoration(
                    hintText: 'Nuevo Correo',
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() {
                    authProvider.actualizarCorreo(_correoController.text);
                    _correoController.clear();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text('Guardar',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Theme.of(context).primaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}